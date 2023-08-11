FROM pytorch/pytorch:latest

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""

RUN apt update && apt install git python3-pip -y && apt clean

ENV ROOT=/stable-diffusion
RUN git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
	cd ${ROOT} && \
	pip install -r requirements.txt

WORKDIR ${ROOT}

RUN cd ./custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    cd ComfyUI-Impact-Pack && \
    git submodule update --init --recursive && \
    python install.py

EXPOSE 5555
CMD python -u main.py --listen --port 5555 ${CLI_ARGS}