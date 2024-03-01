MEMORY {
    sram  (rwx): ORIGIN = 0x20000000, LENGTH = 256k
    flash (rwx): ORIGIN = 0x10000000, LENGTH = 2048k
}

ENTRY(_reset_handler)

SECTIONS {
    . = ORIGIN(sram);
    .text : {
        *(.vectors)
        *(.entry)
        *(.text)
    } > sram
}