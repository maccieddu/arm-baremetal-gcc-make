/* Entry Point */
ENTRY(reset_handler)

/* Specify the memory areas */
MEMORY {
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 256K
    FUSES  (r) : ORIGIN = 0x1FFF7800, LENGTH = 40
    RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

/* Define output sections */
SECTIONS {
    /* The vectors code goes first into FLASH */
    .vector : {
        . = ALIGN(4);
        _svector = .;                  /* Start addr of vector */
        KEEP(*(.vector))
        . = ALIGN(4);
        _evector = .;                  /* End addr of vector */
    } > FLASH

    /* The program code goes into FLASH */
    .text : {
        . = ALIGN(4);
        _stext = .;                    /* Start addr of text */
        *(.text)                       /* .text sections (code) */
        *(.text*)                      /* .text* sections (code) */
        . = ALIGN(4);
        _etext = .;                    /* End addr of text */
    } > FLASH

    /* Constant read-only data goes into FLASH */
    .rodata : {
        . = ALIGN(4);
        _srodata = .;                  /* Start addr of read-only data */
        *(.rodata)                     /* .rodata sections (constants, strings, etc.) */
        *(.rodata*)                    /* .rodata* sections (constants, strings, etc.) */
        . = ALIGN(4);
        _erodata = .;                  /* End addr of read-only data */
        _sidata = .;                   /* !!! Start addr LMA of initialized data !!! */
    } > FLASH

    /* Option Bytes (configuration fuses) */
    .fuses : {
        . = ALIGN(4);
        KEEP(*(.optionbytes1))
        KEEP(*(.optionbytes2))
        KEEP(*(.optionbytes3))
        KEEP(*(.optionbytes4))
		KEEP(*(.optionbytes5))
        . = ALIGN(4);
    } > FUSES

    /* Stack allocated space goes first in RAM
     * (development phase defensive programming)
     * so that in case of stack overflow HardFault will trigger
     * and user can adjust the stack size
     */
    .stack (NOLOAD) : {
        _sstack = .;                   /* Start addr of stack */
        . = ALIGN(8);
        . = . + 0x1000;                /* Stack allocated space */
        . = ALIGN(8);
        _estack = .;                   /* End addr of stack */
    } > RAM

    /* Uninitialized data section */
    .bss (NOLOAD): {
        . = ALIGN(4);
        _sbss = .;                     /* Start addr of bss */
        *(.bss)                        /* .bss sections */
        *(.bss*)                       /* .bss* sections */
        *(COMMON)                      /* COMMON sections */
        . = ALIGN(4);
        _ebss = .;                     /* End addr of bss */
    } > RAM

    /* Initialized data sections goes into RAM, load LMA copy after code */
    .data : {
        . = ALIGN(4);
        _sdata = .;                    /* Start addr of data */
        *(.data)                       /* .data sections */
        *(.data*)                      /* .data* sections */
        . = ALIGN(4);
        _edata = .;                    /* End addr of data */
    } > RAM AT > FLASH
}
