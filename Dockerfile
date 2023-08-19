FROM pytorch/pytorch:latest

RUN apt-get update && apt-get install git python3-pip -y
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"
RUN apt-get install -y tzdata && apt-get install libgl1 python3-opencv -y && apt clean
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118 xformers opencv-python-headless

RUN mkdir /docker
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh

ENV ROOT=/stable-diffusion
RUN mkdir ${ROOT}
RUN git config --global --add safe.directory /stable-diffusion

RUN groupadd user && \
    useradd user -g user -d /stable-diffusion && \
    chown -R user:user /stable-diffusion

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 5555
USER user:user
ENTRYPOINT [ "sh" , "/docker/entrypoint.sh" ]