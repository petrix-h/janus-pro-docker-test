# Use the official NVIDIA CUDA base image; pick a specific tag for your needs.
#FROM nvidia/cuda:11.8.0-base-ubuntu22.04
FROM nvidia/cuda:12.6.3-cudnn-devel-ubuntu24.04
#FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04

# Optionally install other packages you need
#RUN apt-get update && \
#    apt-get install -y --no-install-recommends \
#        git \
#        vim python3 pip \ && \
#    rm -rf /var/lib/apt/lists/*

# Set the default command to run nvidia-smi
#CMD ["nvidia-smi"]


# Install system packages needed for git, Python, pip, venv
#RUN apt-get update && apt-get install -y --no-install-recommends \
# Enable extra repos and install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    git nano htop wget \
    python3 \
    python3-pip \
    python3-venv \
    cmake \
    pkg-config \
    cmake-data
    

#For CPU support: 
#RUN apt-get install -y --no-install-recommends \
#    clang \
#    python3-llvmlite

RUN apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev 
#\ 
#    && \
#    rm -rf /var/lib/apt/lists/*

RUN apt-get install -y --no-install-recommends \
    build-essential 

# Clean out apt caches for a smaller image
#RUN rm -rf /var/lib/apt/lists/*
# Create a working directory
WORKDIR /janus_pro

#Clone Janus repo
RUN git clone https://github.com/deepseek-ai/Janus.git /janus_pro

# Create a virtual environment (named .venv) and install exo in editable mode
# Note: we also upgrade pip here inside the venv, which can help avoid issues
RUN python3 -m venv .venv && \
    . .venv/bin/activate && \
    pip install --upgrade pip 
#&& \
#    pip install -e .[gradio]
#    pip install -e . && \ 
#    pip install llvmlite

#RUN . .venv/bin/activate && \ 
#    pip install -r requirements.txt

RUN . .venv/bin/activate && \
    pip install -e .

RUN apt-get install -y --no-install-recommends \
    python3-dev
# \
#    python3-dev

#For JanusFlow...
RUN pip install diffusers[torch]

RUN . .venv/bin/activate && \
    pip install -e .[gradio]


#llvmlite is for cpu inferencing, but really unstable and feels single core...  not needed for GPU

# Put the venv's bin on PATH so it's is available by default
ENV PATH="/janus_pro/.venv/bin:${PATH}"

# Clean out apt caches for a smaller image
RUN rm -rf /var/lib/apt/lists/*

# Set the default command to run
CMD ["python3", "demo/app_januspro.py"]
