cmake_minimum_required(VERSION 3.20)

set(board teensy-4.1)
set(llvm /Users/purpln/Developer/toolchain-17.0.1)
set(swift /Users/purpln/Desktop/mm-sdk/usr/bin/swiftc)

find_package(Core 1.0.0 CONFIG REQUIRED PATHS /Users/purpln/github/teensy/core/cmake)

project(app C)

file(GLOB sources "sources/*.c")
add_executable(app ${sources})

target_link_libraries(app PRIVATE Core)

add_subdirectory(usb)
target_link_libraries(app PRIVATE usb)

include(flash.cmake)