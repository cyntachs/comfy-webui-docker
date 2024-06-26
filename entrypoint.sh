#!/bin/bash

cd /

if [ ! -f "/stable-diffusion/.installed" ]; then
    echo "Installing ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git /stable-diffusion
    cd /stable-diffusion
    
    cd /stable-diffusion/custom_nodes

    echo "Installing ComfyUI Manager..."
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

    cd /

    touch /stable-diffusion/.installed
elif [ ! -f "/stable-diffusion/custom_nodes/ComfyUI-Manager/__init__.py" ]; then
    echo "Updating ComfyUI..."
    cd /stable-diffusion

    git fetch https://github.com/comfyanonymous/ComfyUI.git
    git pull
fi;

echo "Set permissions..."
chown -R user:user /stable-diffusion

cd /stable-diffusion
if [ ! -d ".venv" ]; then
    echo "Creating venv..."
    python3 -m venv .venv
    source .venv/bin/activate
    python3 -m pip install --upgrade pip
    python3 -m pip install tzdata opencv-python glcontext
    python3 -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
    python3 -m pip install xformers opencv-python-headless
    #python3 -m pip install -r requirements.txt
fi;

source .venv/bin/activate
echo "PIP Install Requirements..."
pip3 install -r requirements.txt

echo "Starting ComfyUI..."
python3 -u main.py --listen --port 5555 ${CLI_ARGS}
