FROM pytorch/pytorch:latest

RUN apt update && apt install git python3-pip -y && apt clean
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118 xformers

RUN mkdir /docker
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh

ENV ROOT=/stable-diffusion
RUN mkdir ${ROOT}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 5555
ENTRYPOINT [ "sh" , "/docker/entrypoint.sh" ]