#!/bin/bash

cd /

# initialize folder
if [ ! -f "/stable-diffusion/.installed" ]; then
    echo "Installing ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git /stable-diffusion
    cd /stable-diffusion
    
    cd /stable-diffusion/custom_nodes

    echo "Installing ComfyUI Manager..."
    git clone https://github.com/Comfy-Org/ComfyUI-Manager.git

    cd /

    touch /stable-diffusion/.installed
elif [ ! -f "/stable-diffusion/custom_nodes/ComfyUI-Manager/__init__.py" ]; then
    echo "Updating ComfyUI..."
    cd /stable-diffusion

    git fetch https://github.com/comfyanonymous/ComfyUI.git
    git pull
    pip3 install -r requirements.txt
fi;

# rebuild venv
if [ -f "/stable-diffusion/.rebuild-venv" ]; then
    rm -rf /venv/*
    
    python3 -m venv /venv
    pip3 install tzdata opencv-python glcontext
    pip3 install torch torchvision torchaudio pillow tqdm xformers --index-url https://download.pytorch.org/whl/cu130
    pip3 install opencv-python-headless
    pip3 install -r https://raw.githubusercontent.com/loscrossos/crossOS_acceleritor/refs/heads/main/acceleritor_torch280cu129_full.txt
    pip3 install -r https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt
    
    rm -f /stable-diffusion/.rebuild-venv

    touch /stable-diffusion/.sage-installed
    touch /stable-diffusion/.use-sage
fi;

# install sage if not installed
if [ ! -f "/stable-diffusion/.sage-installed" ]; then
    cd /stable-diffusion
    
    pip3 install -r https://raw.githubusercontent.com/loscrossos/crossOS_acceleritor/refs/heads/main/acceleritor_torch280cu129_full.txt
    pip3 install -r requirements.txt
    
    cd /
    
    touch /stable-diffusion/.sage-installed
    touch /stable-diffusion/.use-sage
fi;

# reinstall requirements
if [ -f "/stable-diffusion/.req-reinstall" ]; then
    cd /stable-diffusion
    
    pip3 install -r requirements.txt
    
    cd /
    
    rm -f /stable-diffusion/.req-reinstall
fi;

# reinstall requirements (using online requirements)
if [ -f "/stable-diffusion/.req-reinstall-online" ]; then
    cd /stable-diffusion
    
    pip3 install -r https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt
    
    cd /
    
    rm -f /stable-diffusion/.req-reinstall-online
fi;

# start comfyui
cd /stable-diffusion
if [ -f "/stable-diffusion/.use-sage" ]; then
    echo "========== Starting ComfyUI (Sage Attention) =========="
	python3 -u main.py --use-sage-attention --listen --port 5555 ${CLI_ARGS}
else
    echo "========== Starting ComfyUI =========="
	python3 -u main.py --listen --port 5555 ${CLI_ARGS}
fi;
