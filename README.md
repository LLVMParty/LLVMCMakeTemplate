# LLVMCMakeTemplate

Just a simple example of how to properly link to LLVM with CMake on Windows, Linux and macos.

## Requirements

- Visual Studio 2019 or a C++17 compiler that can build LLVM.
- CMake 3.15

**NOTE**: On Windows you may need to [enable long paths](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=cmd#enable-long-paths-in-windows-10-version-1607-and-later) to compile LLVM:

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001
```

You will then need to reboot your machine for the changes to take effect.

## Compiling LLVM

On Windows open a Visual Studio x64 command prompt:

```bash
# Checkout LLVM 15
git clone -b release/15.x --single-branch https://github.com/llvm/llvm-project.git --depth 1
cd llvm-project

# Build LLVM
cmake -G Ninja -B build -S llvm -DCMAKE_BUILD_TYPE=Release "-DLLVM_ENABLE_PROJECTS=clang;lld" -DLLVM_PARALLEL_LINK_JOBS=1 -DLLVM_BUILD_EXAMPLES=OFF -DLLVM_BUILD_TESTS=OFF
cmake --build build
cmake --install build --prefix build/install
```

You can ZIP the install prefix to move it between machines.

## Building the project

```bash
cmake -G Ninja -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH=llvm-project/build/install
cmake --build build
```
