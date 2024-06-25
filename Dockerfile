FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-runtime

LABEL version="py2.2-cuda12.1" maintainer="Cyntachs"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"

ENV NVIDIA_VISIBLE_DEVICES=all PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
COPY . /workspace/

RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw set -eux; \
    apt-get update; \
    apt-get install git python3-pip -y; \
    apt-get install -y tzdata; \
    apt-get install libgl1 python3-opencv -y; \
    apt-get clean; \
    mkdir /stable-diffusion; \
    chmod +x /workspace/entrypoint.sh; \
    git config --global --add safe.directory /stable-diffusion; \
    groupadd user; \
    useradd user -g user -d /stable-diffusion; \
    chown -R user:user /stable-diffusion;

EXPOSE 5555
USER user:user
ENTRYPOINT [ "sh" , "/workspace/entrypoint.sh" ]
