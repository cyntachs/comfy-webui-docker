#!/bin/bash

cd /

if [ ! -f "/stable-diffusion/.installed" ]; then
    echo "Installing ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git /stable-diffusion
    cd /stable-diffusion
	pip install -r requirements.txt
    
    cd /stable-diffusion/custom_nodes

    echo "Installing ComfyUI Manager..."
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

    cd /

    touch /stable-diffusion/.installed
else
    echo "Updating ComfyUI..."
    cd /stable-diffusion

    git fetch https://github.com/comfyanonymous/ComfyUI.git
    git pull
    pip install -r requirements.txt
fi;

echo "Set permissions..."
chown -R user:user /stable-diffusion

cd /stable-diffusion
echo "Starting ComfyUI..."
python -u main.py --listen --port 5555 ${CLI_ARGS}