FROM tensorflow/tensorflow:2.2.3-gpu-py3

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    NVIDIA_REQUIRE_CUDA="cuda>=8.0" \
    LANG=C.UTF-8

RUN mkdir -p /gpt-2/models
WORKDIR /gpt-2
COPY requirements.txt .
RUN pip3 install -r requirements.txt
COPY src /gpt-2/src
CMD ["python3", "src/interactive_server.py"]
