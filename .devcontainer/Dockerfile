FROM ghcr.io/llvmparty/packages/ubuntu:22.04-llvm19.1.0

RUN apt update && apt install -y --no-install-recommends \
    gdb \
    && rm -rf /var/lib/apt/lists/*
