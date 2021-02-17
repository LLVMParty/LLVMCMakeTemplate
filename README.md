# LLVMCMakeTemplate

Just a simple example of how to properly link to LLVM with CMake. It uses [Hunter](https://github.com/cpp-pm/gate) to automatically compile packages to the [HUNTER_ROOT](https://hunter.readthedocs.io/en/latest/reference/user-variables.html#hunter-root) if they are not already there.

## Requirements

- Visual Studio 2019 or a C++14 compiler that can build LLVM.
- CMake 3.15

## Building

```bash
mkdir build && cd build
cmake ..
```

