set(MCU_NAME      imxrt1062)
set(TARGET        thumbv7em-none-unknown-eabihf)
set(LINKER_SCRIPT boards/teensy/imxrt1062.ld)

list(APPEND TOOLCHAIN_BOARD_FLAGS
  -mthumb
  -mcpu=cortex-m7
  -mfpu=fpv5-d16
  -mfloat-abi=hard
  -nostdlib
)

list(APPEND TOOLCHAIN_DEFINES_FLAGS
  __IMXRT1062__
  F_CPU=600000000
  THREAD_API_INLINED
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

list(APPEND TOOLCHAIN_LINKER_FLAGS
  --print-memory-usage
  --gc-sections
  --trace
# --cref
# -v
)

list(APPEND TOOLCHAIN_Swift_FLAGS
  -parse-stdlib
  -nostdimport
# -v
  -target-cpu cortex-m7
  -Xcc -mhard-float
  -Xcc -mfloat-abi=hard
  -use-ld=lld
)