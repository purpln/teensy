# uswift
cmake -B .build -D CMAKE_C_COMPILER:FILEPATH=/Users/purpln/github/sdk/toolchain/usr/bin/clang-13 -D CMAKE_CXX_COMPILER:FILEPATH=/Users/purpln/github/sdk/toolchain/usr/bin/clang-13 -G Ninja -S .

ninja -C .build
