MEMORY {
    sram  (rwx): ORIGIN = __sram,  LENGTH = __sram_size
	itcm  (rwx): ORIGIN = __itcm,  LENGTH = __itcm_size
	dtcm  (rwx): ORIGIN = __dtcm,  LENGTH = __dtcm_size
    flash (rwx): ORIGIN = __flash, LENGTH = __flash_size
}

ENTRY(_reset_handler)

SECTIONS {
    __stack = ORIGIN(sram) + LENGTH(sram);

	.ARM.exidx : {
		*(.ARM.exidx* .ARM.extab.text*)
	} > itcm AT > flash

    .boot : {
        KEEP(*(.boot.conf))
		/*FILL(0x00)*/
		. = ORIGIN(flash) + 0x1000;
		KEEP(*(.boot.ivt))
		KEEP(*(.boot.bootdata))
		KEEP(*(.boot.vectors))
		KEEP(*(.startup))
		*(.progmem*)
		. = ALIGN(4);
        KEEP(*(.init))
        /*__preinit_array_start = .;*/
        KEEP(*(.preinit_array))
        /*__preinit_array_end = .;*/
        /*__init_array_start = .;*/
        KEEP(*(.init_array))
        /*__init_array_end = .;*/
        . = ALIGN(16);
    } > flash
/*
	.interrupts : {
		. = ALIGN(4);
		KEEP(*(.isr_vector))
		. = ALIGN(4);
	} > itcm
*/
	.text.itcm : {
		. = . + 32; /* MPU to trap NULL pointer deref */
		*(.fastrun)
		*(.text*)
		. = ALIGN(16);
	} > itcm AT > flash

	.data : {
		*(.rodata*)
        *(.data*)
        . = ALIGN(16);
		KEEP(*(.vectorsram))
	} > dtcm AT > flash
/*
    .tdata : ALIGN(__tls_align) {
        *(.tdata .tdata.*)
		__data_end = .;
    } > dtcm AT > flash
*/
	.bss : {
		. = ALIGN(4);
        *(.bss*)
        *(COMMON)
        . = ALIGN(32);
        . = . + 32; /* MPU to trap stack overflow */
	} > dtcm

	.bss.dma (NOLOAD) : {
		*(.dmabuffers)
		. = ALIGN(32);
	} > sram

	.swift5 : {
		. = ALIGN(4);
		__start_swift5_protocols = .;
		*(swift5_protocols*)
		__stop_swift5_protocols = .;
		. = ALIGN(4);
		__start_swift5_protocol_conformances = .;
		*(swift5_protocol_conformances*)
		__stop_swift5_protocol_conformances = .;
		. = ALIGN(4);
		__start_swift5_type_metadata = .;
		*(swift5_type_metadata*)
		__stop_swift5_type_metadata = .;
		. = ALIGN(4);
		__start_swift5_typeref = .;
		*(swift5_typeref*)
		__stop_swift5_typeref = .;
		. = ALIGN(4);
		__start_swift5_reflstr = .;
		*(swift5_reflstr*)
		__stop_swift5_reflstr = .;
		. = ALIGN(4);
		__start_swift5_fieldmd = .;
		*(swift5_fieldmd*)
		__stop_swift5_fieldmd = .;
		. = ALIGN(4);
		__start_swift5_assocty = .;
		*(swift5_assocty*)
		__stop_swift5_assocty = .;
		. = ALIGN(4);
		__start_swift5_replace = .;
		*(swift5_replace*)
		__stop_swift5_replace = .;
		. = ALIGN(4);
		__start_swift5_replac2 = .;
		*(swift5_replac2*)
		__stop_swift5_replac2 = .;
		. = ALIGN(4);
		__start_swift5_builtin = .;
		*(swift5_builtin*)
		__stop_swift5_builtin = .;
		. = ALIGN(4);
		__start_swift5_capture = .;
		*(swift5_capture*)
		__stop_swift5_capture = .;
		. = ALIGN(4);
		__start_swift5_mpenum = .;
		*(swift5_mpenum*)
		__stop_swift5_mpenum = .;
		. = ALIGN(4);
		__start_swift5_accessible_functions = .;
		*(swift5_accessible_functions*)
		__stop_swift5_accessible_functions = .;
		. = ALIGN(4);
		__start_swift5_runtime_attributes = .;
		*(swift5_runtime_attributes*)
		__stop_swift5_runtime_attributes = .;
	} > sram
/*
    .tbss (NOLOAD) : {
		*(.tbss .tbss.*)
		*(.tcommon)
		__tls_end = .;
	} > dtcm AT > flash
*/
	/DISCARD/ : { *(.ARM.*) }

/*
    __data_start = ADDR(.data);
    __data_source = LOADADDR(.data);
    __data_size = LOADADDR(.tdata) - ADDR(.data);
    __arm32_tls_tcb_offset = MAX(8, __tls_align);
    __tls_base = ADDR(.tdata);
    __tls_align = MAX(ALIGNOF(.tdata), ALIGNOF(.tbss));
*/

    _stext = ADDR(.text.itcm);
	_etext = ADDR(.text.itcm) + SIZEOF(.text.itcm) + SIZEOF(.ARM.exidx);
	_stextload = LOADADDR(.text.itcm);

	_sdata = ADDR(.data);
	_edata = ADDR(.data) + SIZEOF(.data);
	_sdataload = LOADADDR(.data);

	_sbss = ADDR(.bss);
	_ebss = ADDR(.bss) + SIZEOF(.bss);

	_heap_start = ADDR(.bss.dma) + SIZEOF(.bss.dma);
	_heap_end = ORIGIN(sram) + LENGTH(sram);

	_itcm_block_count = (SIZEOF(.text.itcm) + SIZEOF(.ARM.exidx) + 0x7FFF) >> 15;
	_flexram_bank_config = 0xAAAAAAAA | ((1 << (_itcm_block_count * 2)) - 1);
	_estack = ORIGIN(dtcm) + ((16 - _itcm_block_count) << 15);

	_flashimagelen = SIZEOF(.boot) + SIZEOF(.text.itcm) + SIZEOF(.data);
}