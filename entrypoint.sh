#!/bin/bash

cd /

# initialize folder
if [ ! -f "/stable-diffusion/.installed" ]; then
    echo "Installing ComfyUI..."
    git clone https://github.com/Comfy-Org/ComfyUI.git /stable-diffusion
    cd /stable-diffusion
    
    cd /stable-diffusion/custom_nodes

    echo "Installing ComfyUI Manager..."
    git clone https://github.com/Comfy-Org/ComfyUI-Manager.git

    cd /

    touch /stable-diffusion/.installed
elif [ ! -f "/stable-diffusion/custom_nodes/ComfyUI-Manager/__init__.py" ]; then
    echo "Updating ComfyUI..."
    cd /stable-diffusion

    git fetch https://github.com/Comfy-Org/ComfyUI.git
    git pull
    pip3 install -r requirements.txt
fi;

# rebuild venv
if [ -f "/stable-diffusion/.rebuild-venv" ]; then
    rm -rf /venv/*
    
    python3 -m venv /venv
    /venv/bin/python3 -m pip install tzdata opencv-python glcontext
    /venv/bin/python3 -m pip install torch==2.11.0 torchvision==0.26.0 pillow tqdm xformers --index-url https://download.pytorch.org/whl/cu130
    /venv/bin/python3 -m pip install torchaudio==2.8.0
    /venv/bin/python3 -m pip install opencv-python-headless
    /venv/bin/python3 -m pip install -r https://raw.githubusercontent.com/Comfy-Org/ComfyUI/master/requirements.txt
    
    rm -f /stable-diffusion/.rebuild-venv
fi;

# using sage
if [ -f "/stable-diffusion/.use-sage" ]; then
    # install sage if not installed
    if [ ! -f "/stable-diffusion/.sage-installed" ]; then
        cd /stable-diffusion
    
        pip3 install -r https://raw.githubusercontent.com/loscrossos/crossOS_acceleritor/refs/heads/main/acceleritor_torch280cu129_full.txt
        
        cd /
        
        touch /stable-diffusion/.sage-installed
        touch /stable-diffusion/.req-reinstall-online
    fi;
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
    
    pip3 install -r https://raw.githubusercontent.com/Comfy-Org/ComfyUI/master/requirements.txt
    
    cd /
    
    rm -f /stable-diffusion/.req-reinstall-online
fi;

# start comfyui
cd /stable-diffusion
if [ -f "/stable-diffusion/.use-sage" ]; then
    echo "========== Starting ComfyUI (Sage Attention) =========="
    python3 -c "import sys; print(sys.version + ' ---- '+ sys.executable)"
    python3 -c "import torch; print(torch.__version__)"
	python3 -u main.py --use-sage-attention --listen --port 5555 ${CLI_ARGS}
else
    echo "========== Starting ComfyUI =========="
    python3 -c "import sys; print(sys.version + ' ---- '+ sys.executable)"
    python3 -c "import torch; print(torch.__version__)"
	python3 -u main.py --listen --port 5555 ${CLI_ARGS}
fi;
