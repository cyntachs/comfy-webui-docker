# comfy-webui-docker
A Docker container of ComfyUI for stable-diffusion with ComfyUI Manager

The whole ComfyUI install is stored in an external mount, only the container gets changed during restart or update.

## Installation
Installing via Docker Compose is recommended. This image only supports CPU or Nvidia. 

You can use this template (or the compose file provided in the repo) to run ComfyUI using Docker Compose:
```yml
version: '3.9'

volumes:
  comfyui-docker-venv:
    name: comfyui-docker-venv

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
      - comfyui-docker-venv:/venv
      - /Path/To/Data/:/stable-diffusion
    environment:
      - TZ="America/New_York"
      - CLI_ARGS=
    logging:
      options:
        max-size: 10m
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

Or you can clone this repo, go into the repo folder and run:
```bash
docker compose up --build
```
