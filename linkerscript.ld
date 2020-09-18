ENTRY(reset_handler)

MEMORY {
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 256K
    RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

SECTIONS {
    .vector : {
        _svector = .;
        . = ALIGN(4);
        KEEP(*(.vector))
        . = ALIGN(4);
        _evector = .;
    } > FLASH

    .text : {
        _stext = .;
        *(.text*)
        *(.rodata*)
        _etext = .;
    } > FLASH

    .stack (NOLOAD) : {
        _StackStart = .;
        . = ALIGN(8);
        . = . + 0x1000;
        . = ALIGN(8);
        _StackEnd = .;
    } > RAM

    .bss (NOLOAD): {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > RAM

    .data : {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > RAM AT > FLASH

}