FROM pytorch/pytorch:latest

ENV NVIDIA_VISIBLE_DEVICES=all
ENV CLI_ARGS=""

RUN apt update && apt install git python3-pip libsm6 libxext6 -y && apt clean

ENV ROOT=/stable-diffusion
RUN git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
	cd ${ROOT} && \
	pip install -r requirements.txt

RUN cd ${ROOT}/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

WORKDIR ${ROOT}
EXPOSE 5555
CMD python -u main.py --listen --port 5555 ${CLI_ARGS}