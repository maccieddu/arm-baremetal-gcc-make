.syntax unified
@------------------------------------------------------------------------------
@                                                                       GLOBALS
@------------------------------------------------------------------------------
.global g_pfnVectors
.global reset_handler
.global default_handler
@------------------------------------------------------------------------------
@                                                                        MACROS
@------------------------------------------------------------------------------
.macro def_irq_handler handler_name
.weak  \handler_name
.set   \handler_name, default_handler
.endm
@--------------------------------------
@                            EXCEPTIONS
@--------------------------------------
def_irq_handler nmi_irq_handler
def_irq_handler hardfault_irq_handler
def_irq_handler memmanage_irq_handler
def_irq_handler busfault_irq_handler
def_irq_handler usagefault_irq_handler
@ Reserved
@ Reserved
@ Reserved
@ Reserved
def_irq_handler svc_irq_handler
def_irq_handler debugmon_irq_handler
@ Reserved
def_irq_handler pendsv_irq_handler
def_irq_handler systick_irq_handler
@--------------------------------------
@                            INTERRUPTS
@--------------------------------------
def_irq_handler wwdg_irq_handler
def_irq_handler pvd_pvm_irq_handler
def_irq_handler rtc_stamp_irq_handler
def_irq_handler rtc_wkup_irq_handler
def_irq_handler flash_irq_handler
def_irq_handler rcc_irq_handler
def_irq_handler exti0_irq_handler
def_irq_handler exti1_irq_handler
def_irq_handler exti2_irq_handler
def_irq_handler exti3_irq_handler
def_irq_handler exti4_irq_handler
def_irq_handler dma1_ch1_irq_handler
def_irq_handler dma1_ch2_irq_handler
def_irq_handler dma1_ch3_irq_handler
def_irq_handler dma1_ch4_irq_handler
def_irq_handler dma1_ch5_irq_handler
def_irq_handler dma1_ch6_irq_handler
def_irq_handler dma1_ch7_irq_handler
def_irq_handler adc1_irq_handler
def_irq_handler can1_tx_irq_handler
def_irq_handler can1_rx0_irq_handler
def_irq_handler can1_rx1_irq_handler
def_irq_handler can1_sce_irq_handler
def_irq_handler exti9_5_irq_handler
def_irq_handler tim1_brk_tim15_irq_handler
def_irq_handler tim1_up_tim16_irq_handler
def_irq_handler tim1_trg_com_irq_handler
def_irq_handler tim1_cc_irq_handler
def_irq_handler tim2_irq_handler
@ Reserved
@ Reserved
def_irq_handler i2c1_ev_irq_handler
def_irq_handler i2c1_er_irq_handler
def_irq_handler i2c2_ev_irq_handler
def_irq_handler i2c2_er_irq_handler
def_irq_handler spi1_irq_handler
def_irq_handler spi2_irq_handler
def_irq_handler usart1_irq_handler
def_irq_handler usart2_irq_handler
def_irq_handler usart3_irq_handler
def_irq_handler exti15_10_irq_handler
def_irq_handler rtc_alarm_irq_handler
@ Reserved
@ Reserved
@ Reserved
@ Reserved
@ Reserved
@ Reserved
@ Reserved
def_irq_handler sdmmc1_irq_handler
@ Reserved
def_irq_handler spi3_irq_handler
@ Reserved
@ Reserved
def_irq_handler tim6_dacunder_irq_handler
def_irq_handler tim7_irq_handler
def_irq_handler dma2_ch1_irq_handler
def_irq_handler dma2_ch2_irq_handler
def_irq_handler dma2_ch3_irq_handler
def_irq_handler dma2_ch4_irq_handler
def_irq_handler dma2_ch5_irq_handler
@ Reserved
@ Reserved
@ Reserved
def_irq_handler comp_irq_handler
def_irq_handler lptim1_irq_handler
def_irq_handler lptim2_irq_handler
@ Reserved
def_irq_handler dma2_ch6_irq_handler
def_irq_handler dma2_ch7_irq_handler
def_irq_handler lpuart1_irq_handler
def_irq_handler quadspi_irq_handler
def_irq_handler i2c3_ev_irq_handler
def_irq_handler i2c3_er_irq_handler
def_irq_handler sai1_irq_handler
@ Reserved
def_irq_handler swpmi1_irq_handler
def_irq_handler tsc_irq_handler
@ Reserved
@ Reserved
def_irq_handler rng_irq_handler
def_irq_handler fpu_irq_handler
def_irq_handler crs_irq_handler
@ Reserved
@ Reserved
@------------------------------------------------------------------------------
@                                                                          EQUS
@------------------------------------------------------------------------------
.equ SCB_CPACR, 0xE000ED88
.equ SCB_CPACR_EN, 0x00F00000
@------------------------------------------------------------------------------
@                                                                  VECTOR TABLE
@------------------------------------------------------------------------------
.section .vector,"a",%progbits
.type g_pfnVectors, %object
g_pfnVectors:
    @ From addr 0x0000-0000
    @----------------------------------  Exceptions
    .word _estack                      @ From linkerscript
    .word reset_handler
    .word nmi_irq_handler
    .word hardfault_irq_handler
    .word memmanage_irq_handler
    .word busfault_irq_handler
    .word usagefault_irq_handler
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word svc_irq_handler
    .word debugmon_irq_handler
    .word default_handler              @ Reserved
    .word pendsv_irq_handler
    .word systick_irq_handler
    @----------------------------------  Interrupts
    .word wwdg_irq_handler
    .word pvd_pvm_irq_handler
    .word rtc_stamp_irq_handler
    .word rtc_wkup_irq_handler
    .word flash_irq_handler
    .word rcc_irq_handler
    .word exti0_irq_handler
    .word exti1_irq_handler
    .word exti2_irq_handler
    .word exti3_irq_handler
    .word exti4_irq_handler
    .word dma1_ch1_irq_handler
    .word dma1_ch2_irq_handler
    .word dma1_ch3_irq_handler
    .word dma1_ch4_irq_handler
    .word dma1_ch5_irq_handler
    .word dma1_ch6_irq_handler
    .word dma1_ch7_irq_handler
    .word adc1_irq_handler
    .word can1_tx_irq_handler
    .word can1_rx0_irq_handler
    .word can1_rx1_irq_handler
    .word can1_sce_irq_handler
    .word exti9_5_irq_handler
    .word tim1_brk_tim15_irq_handler
    .word tim1_up_tim16_irq_handler
    .word tim1_trg_com_irq_handler
    .word tim1_cc_irq_handler
    .word tim2_irq_handler
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word i2c1_ev_irq_handler
    .word i2c1_er_irq_handler
    .word i2c2_ev_irq_handler
    .word i2c2_er_irq_handler
    .word spi1_irq_handler
    .word spi2_irq_handler
    .word usart1_irq_handler
    .word usart2_irq_handler
    .word usart3_irq_handler
    .word exti15_10_irq_handler
    .word rtc_alarm_irq_handler
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word sdmmc1_irq_handler
    .word default_handler              @ Reserved
    .word spi3_irq_handler
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word tim6_dacunder_irq_handler
    .word tim7_irq_handler
    .word dma2_ch1_irq_handler
    .word dma2_ch2_irq_handler
    .word dma2_ch3_irq_handler
    .word dma2_ch4_irq_handler
    .word dma2_ch5_irq_handler
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word comp_irq_handler
    .word lptim1_irq_handler
    .word lptim2_irq_handler
    .word default_handler              @ Reserved
    .word dma2_ch6_irq_handler
    .word dma2_ch7_irq_handler
    .word lpuart1_irq_handler
    .word quadspi_irq_handler
    .word i2c3_ev_irq_handler
    .word i2c3_er_irq_handler
    .word sai1_irq_handler
    .word default_handler              @ Reserved
    .word swpmi1_irq_handler
    .word tsc_irq_handler
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .word rng_irq_handler
    .word fpu_irq_handler
    .word crs_irq_handler
    .word default_handler              @ Reserved
    .word default_handler              @ Reserved
    .space 108
    @ To addr 0x0000-0200
@------------------------------------------------------------------------------
@                                                                 RESET_HANDLER
@------------------------------------------------------------------------------
.section .text
.thumb_func
.type reset_handler, %function
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
    bl             main                @ Transfer control to C main() function
    b              .                   @ Endless loop
@------------------------------------------------------------------------------
@                                                               DEFAULT_HANDLER
@------------------------------------------------------------------------------
.section .text
.thumb_func
.weak default_handler
.type default_handler, %function
default_handler:
    b              .                   @ Endless loop
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
    subs           r2, r1, r0          @ Calculate size of the stack section
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
    subs           r2, r1, r0          @ Calculate size of the bss section
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
    ldr            r2, =_edata         @ From linkerscript
    subs           r3, r2, r1          @ Calculate size of the data section
    cmp            r3, #0              @ Check size
    beq            end_copy
copy_data:
    ldrb           r4, [r0], #1        @ r0 source
    strb           r4, [r1], #1        @ r1 destination
    subs           r3, r3, #1
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
@ Option bytes management, change on need...                       OPTION BYTES
@------------------------------------------------------------------------------
.section .optionbytes1 ,"a",%progbits
@------------------
@ .word 0xFEEFF8AA   @ SRAM2 Parity Check Enabled
@ .word 0x01100755   @ Complement
@------------------
@ .word 0xFDEFF8AA   @ SRAM2 Reset on SysReset
@ .word 0x02100755   @ Complement
@------------------
.word 0xFFEFF8AA   @ Default
.word 0x00100755   @ Complement
@------------------
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
