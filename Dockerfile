FROM pytorch/pytorch:latest

RUN apt update && apt install git python3-pip libsm6 libxext6 -y && apt clean

RUN mkdir /docker
# COPY . /docker/
ADD install_scripts /docker

ENV ROOT=/stable-diffusion
RUN mkdir ${ROOT}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 5555
ENTRYPOINT [ "sh" , "/docker/entrypoint.sh" ]