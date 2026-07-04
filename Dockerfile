FROM nvidia/cuda:13.0.2-cudnn-devel-ubuntu24.04

LABEL org.opencontainers.image.title="Comfy-WebUI-Docker"
LABEL org.opencontainers.image.author="Cyntachs"
LABEL org.opencontainers.image.ref.name="Ubuntu24.04-Nvidia"
LABEL org.opencontainers.image.version="pytorch2.11.0+cu130"
LABEL com.nvidia.volumes.needed="nvidia_driver"

ARG DEBIAN_FRONTEND=noninteractive

ENV VIRTUAL_ENV="/venv" PATH="/venv/bin:$PATH"
ENV NVIDIA_VISIBLE_DEVICES=all CLI_ARGS="" TZ="America/New_York"

COPY . /workspace/

RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw --mount=type=cache,target=/root/.cache/pip set -eux; \
    apt-get update; \
    apt-get install --no-install-recommends -y git python3 python3-pip python3-dev python3-venv wget build-essential ffmpeg; \
    mkdir /stable-diffusion; \
    mkdir /venv; \
    git config --global --add safe.directory /stable-diffusion; \
    usermod -d /stable-diffusion ubuntu; \
    chown -R ubuntu:ubuntu /stable-diffusion; \
    chmod 775 -R /stable-diffusion; \
    chmod +x /workspace/entrypoint.sh; \
    python3 -m venv /venv; \
    /venv/bin/python3 -m pip install tzdata opencv-python glcontext; \
    /venv/bin/python3 -m pip install torch==2.11.0 torchvision==0.26.0 pillow tqdm xformers --index-url https://download.pytorch.org/whl/cu130; \
    /venv/bin/python3 -m pip install torchaudio==2.11.0; \
    /venv/bin/python3 -m pip install opencv-python-headless; \
    /venv/bin/python3 -m pip install -r https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt; \
    chown -R ubuntu:ubuntu /venv; 

EXPOSE 5555
USER ubuntu:ubuntu
ENTRYPOINT [ "sh" , "/workspace/entrypoint.sh" ]
