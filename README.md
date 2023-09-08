# comfy-webui-docker
A Docker container of ComfyUI for stable-diffusion with ComfyUI Manager

The whole ComfyUI install is stored in an external mount, only the container gets changed during restart or update.

## Installation
Docker Compose is recommended.

Use this template to run using Docker Compose:
```yml
version: '3.9'

services:
  comfyui-docker:
    container_name: comfy-webui-docker
    #build: # uncomment if building
    #  context: .
    #  dockerfile: Dockerfile
    image: ghcr.io/cyntachs/comfy-webui-docker:main
    ports:
      - 9897:5555
    volumes:
      - /Path/To/Data/:/stable-diffusion
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

Or you can clone this repo, go into the repo folder and run:
```bash
docker compose up --build
```
