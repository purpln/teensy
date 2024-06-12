MEMORY {
    sram  (rwx): ORIGIN = __sram,  LENGTH = __sram_size
	itcm  (rwx): ORIGIN = __itcm,  LENGTH = __itcm_size
	dtcm  (rwx): ORIGIN = __dtcm,  LENGTH = __dtcm_size
    flash (rwx): ORIGIN = __flash, LENGTH = __flash_size
}

ENTRY(_reset_handler)

SECTIONS {
    __stack = ORIGIN(sram) + LENGTH(sram);

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
        KEEP(*(.preinit_array))
        KEEP(*(.init_array))
        . = ALIGN(16);
    } > flash

	.ARM.extab : {
        *(.ARM.extab*)
    } > itcm AT > flash


	.ARM.exidx : {
		. = ALIGN(4);
		__exidx_start = .;
		*(.ARM.exidx* .ARM.extab.text*)
		__exidx_end = .;
	} > itcm AT > flash

	.text.itcm : {
		. = . + 32; /* MPU to trap NULL pointer deref */
		*(.text*)
		. = ALIGN(16);
	} > itcm AT > flash

	.data : {
		*(.rodata*)
        *(.data*)
        . = ALIGN(16);
	} > dtcm AT > flash

	.got : {

	} > dtcm AT > flash

	.bss : {
		. = ALIGN(4);
        *(.bss*)
		*(COMMON)
        . = ALIGN(32);
        . = . + 32; /* MPU to trap stack overflow */
	} > dtcm

	/*
	.bss.dma : {
		*(.dmabuffers)
		. = ALIGN(32);
	} > sram
	*/

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
		*(swift5_reflstr)
		__stop_swift5_reflstr = .;
		
		. = ALIGN(4);
		__start_swift5_fieldmd = .;
		*(swift5_fieldmd)
		__stop_swift5_fieldmd = .;
		
		. = ALIGN(4);
		__start_swift5_assocty = .;
		*(swift5_assocty)
		__stop_swift5_assocty = .;
		
		. = ALIGN(4);
		__start_swift5_replace = .;
		*(swift5_replace)
		__stop_swift5_replace = .;
		
		. = ALIGN(4);
		__start_swift5_replac2 = .;
		*(swift5_replac2)
		__stop_swift5_replac2 = .;
		
		. = ALIGN(4);
		__start_swift5_builtin = .;
		*(swift5_builtin)
		__stop_swift5_builtin = .;
		
		. = ALIGN(4);
		__start_swift5_capture = .;
		*(swift5_capture)
		__stop_swift5_capture = .;
		
		. = ALIGN(4);
		__start_swift5_mpenum = .;
		*(swift5_mpenum)
		__stop_swift5_mpenum = .;
		
		. = ALIGN(4);
		__start_swift5_accessible_functions = .;
		*(swift5_accessible_functions)
		__stop_swift5_accessible_functions = .;

		. = ALIGN(4);
		__start_swift5_accessible_protocol_requirement_functions = .;
		*(swift5_accessible_protocol_requirement_functions)
		__stop_swift5_accessible_protocol_requirement_functions = .;

		. = ALIGN(4);
		__start_swift5_runtime_attributes = .;
		*(swift5_runtime_attributes)
		__stop_swift5_runtime_attributes = .;
	} > itcm AT > flash

	/DISCARD/ : {
		*(.ARM.*);
	}
	
    _stext = ADDR(.text.itcm);
	_etext = ADDR(.text.itcm) + SIZEOF(.text.itcm) + SIZEOF(.ARM.exidx);
	_stextload = LOADADDR(.text.itcm);

	_sdata = ADDR(.data);
	_edata = ADDR(.data) + SIZEOF(.data);
	_sdataload = LOADADDR(.data);

	_sbss = ADDR(.bss);
	_ebss = ADDR(.bss) + SIZEOF(.bss);

	_heap_start = ADDR(.swift5) + SIZEOF(.swift5);
	_heap_end = ORIGIN(sram) + LENGTH(sram);

	_itcm_block_count = (SIZEOF(.text.itcm) + SIZEOF(.ARM.exidx) + 0x7FFF) >> 15;
	_flexram_bank_config = 0xAAAAAAAA | ((1 << (_itcm_block_count * 2)) - 1);
	_estack = ORIGIN(dtcm) + ((16 - _itcm_block_count) << 15);

	_flashimagelen = SIZEOF(.boot) + SIZEOF(.text.itcm) + SIZEOF(.bss) + SIZEOF(.data) + SIZEOF(.swift5);

	__heap_start = _heap_start;
	__heap_end = _heap_end;
}