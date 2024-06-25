FROM ubuntu:22.04 as build

LABEL org.opencontainers.image.title="Comfy-WebUI-Docker"
LABEL org.opencontainers.image.author="Cyntachs"
LABEL org.opencontainers.image.ref.name="ubuntu"
LABEL org.opencontainers.image.version="pytorch2.3.1-cuda12.1"
#LABEL com.nvidia.volumes.needed="nvidia_driver"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"
ENV NVIDIA_VISIBLE_DEVICES=all PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""

COPY . /workspace/

RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw --mount=type=cache,target=/root/.cache/pip set -eux; \
    apt-get update; \
    apt-get install --no-install-recommends -y git python3 python3-pip; \
 #   apt-get install --no-install-recommends -y tzdata; \
 #   apt-get install --no-install-recommends -y libgl1 python3-opencv; \
    pip3 install tzdata opencv-python glcontext; \
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121; \
    pip3 install xformers opencv-python-headless; \
    mkdir /stable-diffusion; \
    chmod +x /workspace/entrypoint.sh; \
    git config --global --add safe.directory /stable-diffusion; \
    groupadd user; \
    useradd user -g user -d /stable-diffusion; \
    chown -R user:user /stable-diffusion;

EXPOSE 5555
USER user:user
ENTRYPOINT [ "sh" , "/workspace/entrypoint.sh" ]
