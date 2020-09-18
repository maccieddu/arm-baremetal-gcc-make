.syntax unified
.arch armv7e-m
.cpu cortex-m4
.thumb

.global reset_handler

.equ SCB_CPACR, 0xE000ED88
.equ SCB_CPACR_EN, 0x00F00000

@--------------------------------------
@ Vector table start
.section .vector,"a",%progbits
.word   _StackEnd
.word   reset_handler
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
.word   0
@ Vector table end
@--------------------------------------
.section .text
reset_handler:
    movs        R0, #0
    mrs         R0, MSP
    msr         PSP, R0
    movs        R0, #0
    movs        R1, #0
    movs        R2, #0
    movs        R3, #0
    movs        R4, #0
    movs        R5, #0
    movs        R6, #0
    movs        R7, #0
    mov         R8, #0
    mov         R9, #0
    mov         R10, #0
    mov         R11, #0
    mov         R12, #0
    ldr         R0, =SCB_CPACR
    ldr         R1, =SCB_CPACR_EN
    str         R1, [R0]
    movs        R0, #0
    movs        R1, #0
    bl          main
    b .
@--------------------------------------
