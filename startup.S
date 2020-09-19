.syntax unified

.global reset_handler

.equ SCB_CPACR, 0xE000ED88
.equ SCB_CPACR_EN, 0x00F00000

@------------------------------------------------------------------------------
@ Vector table start
.section .vector,"a",%progbits
.word   _estack                        @ From linkerscript
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
    bl             setup_sp

    mov            r0, #1
    msr            primask, r0         @ Disable interrupt

    bl             clear_regs
    bl             init_stack          @ Init stack with canary value
    bl             init_bss            @ Init bss with zero value
    bl             init_data           @ Copy initialized data from flash to ram
    bl             fpu_enabling
    bl             clear_regs

    mov            r0, #0
    msr            primask, r0         @ Enable interrupt

    b              main                @ Transfer control to C main() function
    b .
@------------------------------------------------------------------------------
setup_sp:
    mrs            r0, msp
    msr            psp, r0
    mov            pc, lr              @ Return
@------------------------------------------------------------------------------
clear_regs:
    mov            r0, #0
    mov            r1, #0
    mov            r2, #0
    mov            r3, #0
    mov            r4, #0
    mov            r5, #0
    mov            r6, #0
    mov            r7, #0
    mov            r8, #0
    mov            r9, #0
    mov            r10, #0
    mov            r11, #0
    mov            r12, #0
    mov            pc, lr              @ Return
@------------------------------------------------------------------------------
init_stack:
    ldr            r0, =_sstack        @ From linkerscript
    ldr            r1, =_estack        @ From linkerscript
    ldr            r2, =_zstack        @ From linkerscript
    cmp            r2, #0
    beq            end_stack
    mov            r3, #0xA5           @ Canary value
zero_stack:
    strb           r3, [r0], #1
    subs           r2, r2, #1
    bne            zero_stack
end_stack:
    mov            pc, lr              @ return
@------------------------------------------------------------------------------
init_bss:
    ldr            r0, =_sbss          @ From linkerscript
    ldr            r1, =_ebss          @ From linkerscript
    ldr            r2, =_zbss          @ From linkerscript
    cmp            r2, #0
    beq            end_bss
    mov            r3, #0              @ Zero value
zero_bss:
    strb           r3, [r0], #1
    subs           r2, r2, #1
    bne            zero_bss
end_bss:
    mov            pc, lr              @ Return
@------------------------------------------------------------------------------
init_data:
    ldr            r0, =_srodata       @ From linkerscript
    ldr            r1, =_sdata         @ From linkerscript
    ldr            r2, =_zdata         @ From linkerscript
    cmp            r2, #0
    beq            end_copy
copy_data:
    ldrb           r3, [r0], #1        @ r0 source
    strb           r3, [r1], #1        @ r1 destination
    subs           r2, r2, #1
    bne            copy_data
end_copy:
    mov            pc, lr              @ Return
@------------------------------------------------------------------------------
fpu_enabling:
    ldr            r0, =SCB_CPACR
    ldr            r1, =SCB_CPACR_EN
    str            r1, [r0]
    mov            pc, lr              @ Return
@------------------------------------------------------------------------------
