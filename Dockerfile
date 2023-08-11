FROM pytorch/pytorch:latest

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""

RUN apt update && apt install git python3-pip -y && apt clean

ENV ROOT=/stable-diffusion
RUN mkdir ${ROOT}

EXPOSE 5555
ENTRYPOINT [ "sh" , "entrypoint.sh" ]
WORKDIR ${ROOT}
CMD python -u main.py --listen --port 5555 ${CLI_ARGS}