FROM ubuntu:22.04

LABEL org.opencontainers.image.title="Comfy-WebUI-Docker"
LABEL org.opencontainers.image.author="Cyntachs"
LABEL org.opencontainers.image.ref.name="Ubuntu22.04"
LABEL org.opencontainers.image.version="pytorch2.6.0-cuda12.6"
LABEL com.nvidia.volumes.needed="nvidia_driver"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"
ENV NVIDIA_VISIBLE_DEVICES=all PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""

COPY . /workspace/

RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw --mount=type=cache,target=/root/.cache/pip set -eux; \
    apt-get update; \
    apt-get install --no-install-recommends -y git python3 python3-pip; \
    pip3 install tzdata opencv-python glcontext; \
    pip3 install -r https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt; \
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126; \
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
