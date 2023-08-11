#!/bin/bash

echo "Performing update..."

cd /stable-diffusion

git fetch https://github.com/comfyanonymous/ComfyUI.git
git pull

cd ./custom_nodes/ComfyUI-Impact-Pack

git fetch https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
git pull

echo "Done."