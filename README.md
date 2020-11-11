# LLVMCMakeTemplate

Just a simple example of how to properly link to LLVM with CMake.

## Requirements

- Visual Studio 2019
- CMake 3.15
- [LLVM 10](https://github.com/LLVMParty/LLVMCMakeTemplate/releases/tag/llvm10)

## Building

```bash
mkdir build && cd build
cmake -DCMAKE_PREFIX_PATH=c:/llvm10-install-full-v2 ..
```

