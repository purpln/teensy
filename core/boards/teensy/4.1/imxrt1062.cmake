set(TARGET        thumbv7em-none-unknown-eabihf)
set(TARGET_Swift  armv7em-none-none-eabihf)
set(LINKER_SCRIPT imxrt1062.ld)

list(APPEND TOOLCHAIN_BOARD_FLAGS
    -mcpu=cortex-m7
    -mfpu=fpv5-dp-d16
    -mhard-float
    -mfloat-abi=hard
)

list(APPEND TOOLCHAIN_DEFINES_FLAGS
    F_CPU=600000000
)

list(APPEND TOOLCHAIN_Swift_FLAGS
    -target-cpu cortex-m7
    -Xcc -mfpu=fpv5-dp-d16
    -Xcc -mhard-float
    -Xcc -mfloat-abi=hard
)