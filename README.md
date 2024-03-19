### Download
ninja & cmake,
[llvm Toolchain](https://github.com/ARM-software/LLVM-embedded-toolchain-for-Arm/releases),
[Swift snapshot](https://www.swift.org/download/)

### Set up paths in
project/CMakeLists.txt (project example)
```CMake
set(llvm <toolchain path>)
set(swift <swiftc path>)

find_package(Core 1.0.0 CONFIG REQUIRED PATHS <core from this repo path>)
```

### Build
```shell
cmake -B .build -G Ninja -S .
ninja -C .build
```
