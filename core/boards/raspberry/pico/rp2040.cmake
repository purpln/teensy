set(TARGET        thumbv6em-none-unknown-eabi)
set(TARGET_Swift  thumbv6em-unknown-none-eabi)
set(LINKER_SCRIPT rp2040.ld)

list(APPEND TOOLCHAIN_BOARD_FLAGS
    -mthumb
    -mcpu=cortex-m0
    -mfloat-abi=soft
)

list(APPEND TOOLCHAIN_Swift_FLAGS
    -target-cpu cortex-m0
)