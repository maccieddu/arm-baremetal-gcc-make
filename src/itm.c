#include "itm.h"

// Debug Exception and Monitor Control Register base address
#define DEMCR *((volatile unsigned int*) 0xE000EDFCu)

// Istrumentation Trace Macrocell register address
#define ITM_STIMULUS_PORT0 *((volatile unsigned int*) 0xE0000000u)
#define ITM_TRACE_EN *((volatile unsigned int*) 0xE0000E00u)

void ITM_SendChar(unsigned char uc_char) {
    // Enable TRACENA
    DEMCR |= (1u << 24u);
    // Enable ITM Stimulus port 0
    ITM_TRACE_EN |= 0x1u;
    // Polling FIFO status in bit[0]
    while(!(ITM_STIMULUS_PORT0 & 0x1u)) {
        ;
    }
    // Write to ITM Stimulus port 0
    ITM_STIMULUS_PORT0 = uc_char;
}
