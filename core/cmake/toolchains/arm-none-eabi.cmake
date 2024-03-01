set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_BUILD_TYPE Release)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_Swift_COMPILER_WORKS YES)

set(BUILD_SHARED_LIBS NO)
set(BUILD_TESTING NO)

if(APPLE)
    set(CMAKE_OSX_SYSROOT "")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "")
    set(CMAKE_OSX_ARCHITECTURES "")
    set(CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "")
    set(CMAKE_PLATFORM_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")
  
    set(HAVE_FLAG_SEARCH_PATHS_FIRST 0)
endif()

set(LLVM_TOOLCHAIN_PATH  ${llvm})
set(CMAKE_Swift_COMPILER ${swift})
set(CMAKE_C_COMPILER     ${LLVM_TOOLCHAIN_PATH}/bin/clang)
set(CMAKE_CXX_COMPILER   ${LLVM_TOOLCHAIN_PATH}/bin/clang++)
set(CMAKE_OBJCOPY_BIN    ${LLVM_TOOLCHAIN_PATH}/bin/llvm-objcopy)
set(CMAKE_SIZE_BIN       ${LLVM_TOOLCHAIN_PATH}/bin/llvm-size)
set(CMAKE_STRIP          ${LLVM_TOOLCHAIN_PATH}/bin/llvm-strip)
set(CMAKE_AR             ${LLVM_TOOLCHAIN_PATH}/bin/llvm-ar)

list(APPEND TOOLCHAIN_DEFINES_FLAGS

)

list(APPEND TOOLCHAIN_BOARD_FLAGS
    -nostdlib
)

list(APPEND TOOLCHAIN_COMMON_FLAGS
    -fdata-sections
    -ffreestanding
    -funsigned-char
    -ffunction-sections
    -fpack-struct
    -fshort-enums
    -fno-builtin
)

list(APPEND TOOLCHAIN_Swift_FLAGSß
    -use-ld=lld
    -Osize
)

list(APPEND TOOLCHAIN_LINKER_FLAGS
    --print-memory-usage
    --gc-sections
    --trace
)