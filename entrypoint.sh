#!/bin/bash

cd /

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
if [ ! -f "/stable-diffusion/.sage-installed" ]; then
    cd /stable-diffusion
    
    wget https://raw.githubusercontent.com/loscrossos/crossOS_acceleritor/refs/heads/main/acceleritor_torch290cu130_full.txt
    pip3 install -r acceleritor_torch290cu130_full.txt
    pip3 install -r requirements.txt
    
    cd /
    
    touch /stable-diffusion/.sage-installed
fi;
if [ -f "/stable-diffusion/.req-reinstall" ]; then
    cd /stable-diffusion
    
    pip3 install -r requirements.txt
    
    cd /
    
    rm -f /stable-diffusion/.req-reinstall
fi;

cd /stable-diffusion
echo "Starting ComfyUI..."
python3 -u main.py --use-sage-attention --listen --port 5555 ${CLI_ARGS}
