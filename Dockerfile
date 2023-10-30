FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

LABEL version="1.2-cuda12.1" maintainer="Cyntachs"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && \
    apt-get install git python3-pip -y && \
    apt-get install -y tzdata && \
    apt-get install libgl1 python3-opencv -y && \
    apt-get clean
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118 xformers opencv-python-headless

ENV ROOT=/stable-diffusion
RUN mkdir /docker
COPY . /docker/
RUN mkdir ${ROOT} && \
    chmod +x /docker/entrypoint.sh && \
    git config --global --add safe.directory /stable-diffusion

RUN groupadd user && \
    useradd user -g user -d /stable-diffusion && \
    chown -R user:user /stable-diffusion

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 5555
USER user:user
ENTRYPOINT [ "sh" , "/docker/entrypoint.sh" ]
