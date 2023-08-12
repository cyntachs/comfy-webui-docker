#!/bin/bash

cd /

if [ ! -f "/stable-diffusion/.installed" ]; then
    echo "Installing ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git /stable-diffusion
    cd /stable-diffusion
	pip install -r requirements.txt
    
    cd /stable-diffusion/custom_nodes

    echo "Installing Controlnet Preprocessors..."
    git clone https://github.com/Fannovel16/comfy_controlnet_preprocessors
    cd comfy_controlnet_preprocessors
    python install.py

    cd /stable-diffusion/custom_nodes

    echo "Installing Impact Pack..."
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
    cd ComfyUI-Impact-Pack
    git submodule update --init --recursive
    python install.py

    cd /

    touch /stable-diffusion/.installed
else
    chmod +x /docker/update.sh
    sh /docker/update.sh
fi;

cd /stable-diffusion
echo "Starting ComfyUI..."
python -u main.py --listen --port 5555 ${CLI_ARGS}