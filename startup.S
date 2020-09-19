.syntax unified

.global reset_handler

.equ SCB_CPACR, 0xE000ED88
.equ SCB_CPACR_EN, 0x00F00000

@------------------------------------------------------------------------------
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
@------------------------------------------------------------------------------
.section .text
reset_handler:
    bl          setup_sp
    bl          clear_regs
    bl          fpu_enabling
    movs        R0, #0
    movs        R1, #0
    b           main
    b .
@------------------------------------------------------------------------------
setup_sp:
    mrs         R0, MSP
    msr         PSP, R0
    mov         PC, LR  @ return
@------------------------------------------------------------------------------
clear_regs:
    mov         R0, #0
    mov         R1, #0
    mov         R2, #0
    mov         R3, #0
    mov         R4, #0
    mov         R5, #0
    mov         R6, #0
    mov         R7, #0
    mov         R8, #0
    mov         R9, #0
    mov         R10, #0
    mov         R11, #0
    mov         R12, #0
    mov         PC, LR  @ return
@------------------------------------------------------------------------------
fpu_enabling:
    ldr         R0, =SCB_CPACR
    ldr         R1, =SCB_CPACR_EN
    str         R1, [R0]
    mov         PC, LR  @ return
