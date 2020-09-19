# arm-baremetal-gcc-make

This repository is a "work in progress" attempt to create a
make'able' gcc baremetal enviroment for Arm Cortex microcontrollers.

Any help or suggestions are appreciated. :P

STM32L431RCT is the target here.

https://www.st.com/en/microcontrollers-microprocessors/stm32l431rc.html

# Toolchain used:

https://xpack.github.io/arm-none-eabi-gcc/

https://xpack.github.io/windows-build-tools/

# Reference material:

Arm Cortex-M4 Devices Generic User Guide: https://developer.arm.com/documentation/dui0553/b/

Arm Cortex-M4 Processor Technical Reference Manual: https://developer.arm.com/documentation/100166/0001/

ARMv7-M Architecture Reference Manual: https://developer.arm.com/documentation/ddi0403/ed/

CMSIS: https://arm-software.github.io/CMSIS_5/General/html/index.html

FreeRTOS: https://www.freertos.org/


# TODO
1. Improve linkerscript

1.1 Improve sections placement

2. Improve startup asm code

2.1 Write bss section init function

3. Improve makefile

4. Use CMSIS-Core

5. Use FreeRTOS

# NOTE
