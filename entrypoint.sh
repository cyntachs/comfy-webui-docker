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
    
	#rm -f ./acceleritor_torch280cu129_full.txt
    #wget https://raw.githubusercontent.com/loscrossos/crossOS_acceleritor/refs/heads/main/acceleritor_torch280cu129_full.txt
    pip3 install -r https://raw.githubusercontent.com/loscrossos/crossOS_acceleritor/refs/heads/main/acceleritor_torch280cu129_full.txt
    pip3 install -r requirements.txt
    
    cd /
    
    touch /stable-diffusion/.sage-installed
fi;
if [ -f "/stable-diffusion/.req-reinstall" ]; then
    cd /stable-diffusion
    
    pip3 install -r requirements.txt
	
    # comfyui-manager is better at fixing dependencies
	#find ./custom_nodes/ -name "requirements*.txt" -type f | while read -r file; do
	#	pip3 install --upgrade-strategy only-if-needed -r "$file" 
	#done
    
    cd /
    
    rm -f /stable-diffusion/.req-reinstall
fi;
if [ -f "/stable-diffusion/.req-reinstall-online" ]; then
    cd /stable-diffusion
    
    pip3 install -r https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt
    
    cd /
    
    rm -f /stable-diffusion/.req-reinstall
fi;

cd /stable-diffusion
if [ -f "/stable-diffusion/.sage-installed" ]; then
    echo "========== Starting ComfyUI (Sage Attention) =========="
	python3 -u main.py --use-sage-attention --listen --port 5555 ${CLI_ARGS}
else
    echo "========== Starting ComfyUI =========="
	python3 -u main.py --listen --port 5555 ${CLI_ARGS}
fi;
