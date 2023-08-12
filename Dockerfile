FROM pytorch/pytorch:latest

RUN apt update && apt install git python3-pip libsm6 libxext6 -y && apt clean

RUN mkdir /docker
COPY /install_scripts/ /docker/
RUN chmod u+x /docker/entrypoint.sh
# ADD https://github.com/cyntachs/comfy-webui-docker/blob/main/install_scripts/entrypoint.sh /docker/
# ADD https://github.com/cyntachs/comfy-webui-docker/blob/main/install_scripts/update.sh /docker/

ENV ROOT=/stable-diffusion
RUN mkdir ${ROOT}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 5555
ENTRYPOINT [ "/docker/entrypoint.sh" ]