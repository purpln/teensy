cmake_minimum_required(VERSION 3.20)

set(board teensy-4.1)
set(llvm /Users/purpln/Developer/toolchain-18.1.3)
set(swift /Users/purpln/Library/Developer/Toolchains/swift-6.0-DEVELOPMENT-SNAPSHOT-2024-06-08-a.xctoolchain/usr/bin/swiftc)
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