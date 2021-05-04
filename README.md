# LLVMCMakeTemplate

Just a simple example of how to properly link to LLVM with CMake. It uses [Hunter](https://github.com/cpp-pm/gate) to automatically compile packages to the [HUNTER_ROOT](https://hunter.readthedocs.io/en/latest/reference/user-variables.html#hunter-root) if they are not already there.

## Requirements

- Visual Studio 2019 or a C++14 compiler that can build LLVM.
- CMake 3.15

**NOTE**: On Windows you need to [enable long paths](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=cmd#enable-long-paths-in-windows-10-version-1607-and-later) to compile the LLVM package with Hunter:

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001
```

## Building

```bash
mkdir build && cd build
cmake ..
```

