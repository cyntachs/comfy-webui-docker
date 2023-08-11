#!/bin/bash

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

    cd /stable-diffusion

    touch /stable-diffusion/.installed
else
    chmod +x /update.sh
    sh /update.sh
fi;