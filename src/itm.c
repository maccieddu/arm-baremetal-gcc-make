#include "itm.h"

// Stimulus Port registers, ITM_STIM0-ITM_STIM255 base address
#define ITM_STIMx *((volatile unsigned int*) 0xE0000000u)

void ITM_SendChar(unsigned char uc_char) {
    // ITM is enabled by the debugger

    // Polling FIFO status in bit[0]
    while(!(ITM_STIMx & 0x1u)) {
        ;
    }
    // Write to ITM Stimulus port 0
    ITM_STIMx = uc_char;
}
