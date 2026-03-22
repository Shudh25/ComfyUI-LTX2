#!/usr/bin/env bash
# Sun Mar 22 14:00:50 IST 2026

# -----------------------------------------------------------------------------
# ComfyUI + LTX-2 Auto Setup Script
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Clean Previous Installation (if exists)
# -----------------------------------------------------------------------------
cd /
rm -rf /app/ComfyUI


# -----------------------------------------------------------------------------
# Clone ComfyUI Repository
# -----------------------------------------------------------------------------
git clone https://github.com/Comfy-Org/ComfyUI.git
cd ComfyUI

# -----------------------------------------------------------------------------
# Install Python Dependencies
# -----------------------------------------------------------------------------

# pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
# pip install numpy==1.26.4

pip install -r requirements.txt


# -----------------------------------------------------------------------------
# Download Helper Function
# -----------------------------------------------------------------------------
download () {
  local url="$1"; local out="$2"
  if [ ! -f "$out" ]; then
    echo "  ↳ Downloading $(basename "$out")..."
    if command -v aria2c &> /dev/null; then
      aria2c --console-log-level=error -c -x 16 -s 16 -k 1M -d "$(dirname "$out")" -o "$(basename "$out")" "$url"
    else
      wget -q --show-progress -O "$out" "$url"
    fi
  else
    echo "  $(basename "$out") already present."
  fi
}

# -----------------------------------------------------------------------------
# Create Model Directories
# -----------------------------------------------------------------------------
echo "[INFO] Creating model directories..."
mkdir -p /ComfyUI/models/{checkpoints,text_encoders,loras,upscale_models}

# -----------------------------------------------------------------------------
# Download LTX-2 Models
# -----------------------------------------------------------------------------

# MAIN MODEL
download "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors" \
         "/ComfyUI/models/checkpoints/ltx-2-19b-dev-fp8.safetensors"

# TEXT ENCODER
download "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors" \
         "/ComfyUI/models/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors"

# LORA
download "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-distilled-lora-384.safetensors" \
         "/ComfyUI/models/loras/ltx-2-19b-distilled-lora-384.safetensors"

# UPSCALER
download "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-spatial-upscaler-x2-1.0.safetensors" \
           "/ComfyUI/models/latent_upscale_models/ltx-2-spatial-upscaler-x2-1.0.safetensors"


# -----------------------------------------------------------------------------
# Launch Services
# -----------------------------------------------------------------------------

echo "[INFO] Launching ComfyUI + Jupyter..."
cd /ComfyUI

jupyter lab \
  --ip=0.0.0.0 --port=8888 --no-browser --allow-root \
  --ServerApp.token='' \
  --ServerApp.password='' \
  --ServerApp.trust_xheaders=True \
  --ServerApp.allow_origin='*' &

# Start ComfyUI
python3 main.py --listen 0.0.0.0 --port 8188