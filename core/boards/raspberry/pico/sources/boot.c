#include <stdint.h>

extern void main();

#define XIP_SSI_BASE       0x18000000
#define XIP_SSI_CTRLR0     (XIP_SSI_BASE + 0x00)
#define XIP_SSI_CTRLR1     (XIP_SSI_BASE + 0x04)
#define XIP_SSI_SSIENR     (XIP_SSI_BASE + 0x08)
#define XIP_SSI_BAUDR      (XIP_SSI_BASE + 0x14)
#define XIP_SSI_SPI_CTRLR0 (XIP_SSI_BASE + 0xF4)

void copyToRam(void) {
    uint32_t *source = (uint32_t *)0x10000100; // Source address (FLASH)
    uint32_t *destination = (uint32_t *)0x20000100; // Destination (SRAM)
    uint32_t size = 0x1000; // Size of code

    while (size > 0) {
        // load 16 bytes from FLASH to RAM at a time
        for (int i = 0; i < 4; i++) {
            destination[i] = source[i];
        }
        source += 4;
        destination += 4;
        size -= 16;
    }
}

void configureSSI(void) {
    *(volatile uint32_t *)XIP_SSI_SSIENR = 0x00000000;
    *(volatile uint32_t *)XIP_SSI_CTRLR0 = 0x001F0300;
    *(volatile uint32_t *)XIP_SSI_BAUDR = 0x00000008;
    *(volatile uint32_t *)XIP_SSI_SPI_CTRLR0 = 0x03000218;
    *(volatile uint32_t *)XIP_SSI_CTRLR1 = 0x00000000;
    *(volatile uint32_t *)XIP_SSI_SSIENR = 0x00000001;
}

void _reset_handler(void) {
    configureSSI();
    copyToRam();
    main();
}

