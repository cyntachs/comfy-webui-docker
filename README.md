# comfy-webui-docker
A Docker container of ComfyUI for stable-diffusion with ComfyUI Manager

The whole ComfyUI install is stored in an external mount, only the container gets changed during restart or update.

## Installation
Docker Compose is recommended.

```yml
version: '3.9'

services:
  comfyui-docker:
    container_name: comfy-webui-docker
    image: ghcr.io/cyntachs/comfy-webui-docker:main
    ports:
      - 8188:5555
    volumes:
      - /path/to/data:/stable-diffusion
    environment:
      - TZ="America/New_York"
      - CLI_ARGS=
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              device_ids: ['0']
              capabilities: [compute, utility]
```
