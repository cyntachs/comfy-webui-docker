#!/bin/bash

echo "Performing update..."

cd /stable-diffusion

git fetch https://github.com/comfyanonymous/ComfyUI.git
git pull

cd /stable-diffusion/custom_nodes/comfy_controlnet_preprocessors

git fetch https://github.com/Fannovel16/comfy_controlnet_preprocessors
git pull

cd /stable-diffusion/custom_nodes/ComfyUI-Impact-Pack

git fetch https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
git pull

cd /

echo "Done."