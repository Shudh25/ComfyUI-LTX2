# ComfyUI-LTX2

This repository provides a **fully automated setup** for running **ComfyUI with LTX-2 video model** on GPU environments (e.g., RunPod, AWS, local CUDA machines).

**LTX-2** is the first DiT-based audio-video foundation model that contains all core capabilities of modern video generation in one model: synchronized audio and video, high fidelity, multiple performance modes, production-ready outputs, API access, and open access.

<div align="center">
  <video src="https://github.com/user-attachments/assets/4414adc0-086c-43de-b367-9362eeb20228" width="70%" poster=""> </video>
</div>

It installs:

* ComfyUI (latest)
* LTX-2 model (19B)
* Text encoder (Gemma 3 12B)
* LoRA + Upscaler
* Jupyter Lab (for remote control)
* Preconfigured workflow (`ltx2api.json`)

---

## 📦 Folder Structure

```
ComfyUI-LTX2/
├── Dockerfile
├── script.sh
├── ltx2api.json
└── README.md
```

---

## ⚡ Features

* 🔥 One-command setup
* 🎥 LTX-2 video generation pipeline
* 📦 Auto-downloads all required models
* 🧠 Optimized for GPU environments
* 🌐 Exposes:

  * ComfyUI → `8188`
  * Jupyter → `8888`

---

## 🧪 Tested Environment

✅ Successfully tested on:

* **RunPod GPU (RTX 5090)**

> Note: High VRAM GPUs (24GB+) are recommended for smooth performance.

---

## 🚀 Quick Start (RunPod / Docker)

### 1. Build Image

```bash
docker build -t comfyui-ltx2 .
```

### 2. Run Container

```bash
docker run --gpus all -p 8188:8188 -p 8888:8888 comfyui-ltx2
```

---

## 🌐 Access Services

| Service | URL                                            |
| ------- | ---------------------------------------------- |
| ComfyUI | [http://localhost:8188](http://localhost:8188) |
| Jupyter | [http://localhost:8888](http://localhost:8888) |

(No token/password required — already disabled)

---

## 🧠 Models Included

* `ltx-2-19b-dev-fp8` (Main model)
* `gemma_3_12B_it_fp4` (Text encoder)
* `ltx-2 distilled LoRA`
* `LTX spatial upscaler x2`

---

## 🎬 Workflow

The file `ltx2api.json` contains a **ready-to-use LTX-2 pipeline**:

* Text → Video generation
* Audio + Video latent fusion
* Upscaling + decoding
* Final MP4 output

Import it in ComfyUI:

```
Load → ltx2api.json
```

---

## ⚠️ Notes

* Requires **high VRAM GPU (24GB+ recommended)**
* First startup will take time (model downloads)
* Designed for **LTX-2 (NOT LTX-1)**

---

## 🔧 Customization

You can:

* Replace prompts inside workflow
* Adjust frame count, FPS, scheduler
* Add custom LoRAs

---

## 📌 Future Improvements

* LTX 2.3 support
* API wrapper
* Multi-GPU support
* Persistent volumes


## 📚 References

This project builds upon and integrates the following open-source projects:

* 🔗 **ComfyUI-LTX2 Repository**
  https://github.com/Shudh25/ComfyUI-LTX2.git
  → Custom setup, automation scripts, and deployment configuration for LTX-2

* 🔗 **ComfyUI (Official Repository)**
  https://github.com/Comfy-Org/ComfyUI.git
  → Core node-based UI framework powering the workflow engine

---

## 👨‍💻 Author

Shudhansu Pandey

