/* Entry Point */
ENTRY(reset_handler)

/* Specify the memory areas */
MEMORY {
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 256K
    RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

/* Define output sections */
SECTIONS {
    /* The vector code goes first into FLASH */
    .vector : {
        . = ALIGN(4);
        _svector = .;
        KEEP(*(.vector))
        . = ALIGN(4);
        _evector = .;
        _zvector = _evector - _svector;
    } > FLASH

    /* The program code and other data goes into FLASH */
    .text : {
        . = ALIGN(4);
        _stext = .;
        *(.text)           /* .text sections (code) */
        *(.text*)          /* .text* sections (code) */
        . = ALIGN(4);
        _etext = .;
        _ztext = _etext - _stext;
    } > FLASH

    /* Constant data goes into FLASH */
    .rodata : {
        . = ALIGN(4);
        _srodata = .;
        *(.rodata)         /* .rodata sections (constants, strings, etc.) */
        *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
        . = ALIGN(4);
        _erodata = .;
        _zrodata = _erodata - _srodata;
    } > FLASH

    .stack (NOLOAD) : {
        _sstack = .;
        . = ALIGN(8);
        . = . + 0x1000;
        . = ALIGN(8);
        _estack = .;
        _zstack = _estack - _sstack;
    } > RAM

    /* Uninitialized data section */
    .bss (NOLOAD): {
        . = ALIGN(4);
        _sbss = .;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
        _zbss = _ebss - _sbss;
    } > RAM

    /* Initialized data sections goes into RAM, load LMA copy after code */
    .data : {
        . = ALIGN(4);
        _sdata = .;
        *(.data)           /* .data sections */
        *(.data*)          /* .data* sections */
        . = ALIGN(4);
        _edata = .;
        _zdata = _edata - _sdata;
    } > RAM AT > FLASH
}