cmake_minimum_required(VERSION 3.20)

set(board teensy-4.1)
set(llvm /Users/purpln/Developer/toolchain-17.0.1)
set(swift /Users/purpln/Desktop/mm-sdk/usr/bin/swiftc)
set(uswift /Users/purpln/github/uswift)

find_package(Core 1.0.0 CONFIG REQUIRED PATHS /Users/purpln/github/teensy/core/cmake)

project(app C)

add_subdirectory(swift)

file(GLOB sources sources/*.c)
add_executable(app ${sources})

target_link_libraries(app PRIVATE Core)

add_dependencies(app test)
target_link_libraries(app PUBLIC "-nostdlib test.o")
#target_sources(app PRIVATE test.o)

include(flash.cmake)