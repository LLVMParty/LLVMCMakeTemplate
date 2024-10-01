FROM ghcr.io/llvmparty/packages/ubuntu:22.04-llvm19.1.0

RUN apt update && apt install -y \
    git \
    clangd \
    clang-format \
    cmake \
    ninja-build \
    gdb \
    ninja-build \
    python3 \
    python3-pip \
    python3-venv \
    sudo \
    && rm -rf /var/lib/apt/lists/*