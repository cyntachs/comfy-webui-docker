FROM pytorch/pytorch:latest

ENV NVIDIA_VISIBLE_DEVICES=all
ENV CLI_ARGS=""

RUN apt update && apt install git python3-pip libsm6 libxext6 -y && apt clean

RUN mkdir /docker
COPY . /docker/
RUN chmod u+x /docker/update.sh

ENV ROOT=/stable-diffusion
RUN git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
	cd ${ROOT} && \
	pip install -r requirements.txt

WORKDIR ${ROOT}/custom_nodes
RUN git clone https://github.com/Fannovel16/comfy_controlnet_preprocessors && \
    cd comfy_controlnet_preprocessors && \
    python install.py

WORKDIR ${ROOT}/custom_nodes
RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    cd ComfyUI-Impact-Pack && \
    git submodule update --init --recursive && \
    python install.py

WORKDIR ${ROOT}
EXPOSE 5555
ENTRYPOINT [ "update.sh" ]
CMD python -u main.py --listen --port 5555 ${CLI_ARGS}