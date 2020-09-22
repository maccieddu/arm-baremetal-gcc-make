/* Entry Point */
ENTRY(reset_handler)

/* Specify the memory areas */
MEMORY {
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 256K
    FUSES  (r) : ORIGIN = 0x1FFF7800, LENGTH = 40
    RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

_eram = 0x20000000 + 64K;              /* End addr of SRAM */

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
        . = ALIGN(8);
        _sstack = .;                   /* Start addr of stack */
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

    /* Explicitly discard sections that we don't need. */
    /DISCARD/ :
    {
        *(.glue_7)                     /* glue arm to thumb code */
        *(.glue_7t)                    /* glue thumb to arm code */
        *(.eh_frame)
        *(.v4_bx)                      /* ARMv4 interworking fixup for missing BX */
        *(.vfp11_veneer)               /* VFP11 bugfixes s.a. http://sourceware.org/ml/binutils/2006-12/msg00196.html */
        *(.iplt .igot.plt)             /* STT_GNU_IFUNC symbols */
        *(.rel.*)                      /* dynamic relocations */
        *(.ARM.exidx* .gnu.linkonce.armexidx.*) /* index entries for section unwinding */
        *(.ARM.extab* .gnu.linkonce.armextab.*) /* exception unwinding information */
    }

    .ARM.attributes 0 : { *(.ARM.attributes) }
}
