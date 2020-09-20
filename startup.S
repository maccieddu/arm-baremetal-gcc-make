.syntax unified
@------------------------------------------------------------------------------
.macro def_irq_handler handler_name
.weak  \handler_name
.set   \handler_name, default_handler
.endm
def_irq_handler    nmi_handler
def_irq_handler    hardfault_handler
def_irq_handler    memmanage_handler
def_irq_handler    busfalut_handler
def_irq_handler    usagefault_handler
def_irq_handler    svc_handler
def_irq_handler    debugmon_handler
def_irq_handler    pendsv_handler
def_irq_handler    systick_handler
@------------------------------------------------------------------------------
.equ SCB_CPACR, 0xE000ED88
.equ SCB_CPACR_EN, 0x00F00000
@------------------------------------------------------------------------------
@ Vector table start
.section .vector,"a",%progbits
.global g_pfnVectors
.type g_pfnVectors, %object
g_pfnVectors:
    @ From 0x0000-0000
    .word _estack                      @ From linkerscript
    .word reset_handler
    .word nmi_handler
    .word hardfault_handler
    .word memmanage_handler
    .word busfalut_handler
    .word usagefault_handler
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word svc_handler
    .word debugmon_handler
    .word default_handler              @ Reserved
    .word pendsv_handler
    .word systick_handler
    .space 448
    @ To 0x0000-0200
@ Vector table end
@------------------------------------------------------------------------------
.section .text
.thumb_func
.global reset_handler
.type   reset_handler, %function
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
    b              .
@------------------------------------------------------------------------------
.thumb_func
.weak default_handler
.type default_handler, %function
default_handler:
    b              .
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
    cmp            r2, #0              @ Check size
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
    cmp            r2, #0              @ Check size
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
    ldr            r0, =_sidata        @ From linkerscript (LMA)
    ldr            r1, =_sdata         @ From linkerscript (VMA)
    ldr            r2, =_zdata         @ From linkerscript
    cmp            r2, #0              @ Check size
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
@ Option bytes management, change on need...
@------------------------------------------------------------------------------
.section .optionbytes1 ,"a",%progbits
.word 0xFFEFF8AA
.word 0x00100755   @ Complement
.section .optionbytes2 ,"a",%progbits
.word 0xFFFFFFFF
.word 0x00000000   @ Complement
.section .optionbytes3 ,"a",%progbits
.word 0xFFFF0000
.word 0x0000FFFF   @ Complement
.section .optionbytes4 ,"a",%progbits
.word 0xFF00FFFF
.word 0x00FF0000   @ Complement
.section .optionbytes5 ,"a",%progbits
.word 0xFF00FFFF
.word 0x00FF0000   @ Complement