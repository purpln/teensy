#include <stdio.h>
#include <stdlib.h>
#include <board.h>
#include <stdatomic.h>
#include <delay.h>
#include <usb.h>
#include <serial.h>
#include <wchar.h>

//extern int32_t test(int32_t, int32_t);

void write() {
    //int32_t swift = test(40, 2);
    wchar_t text[8] = L"echo v"; //L"\r\n"
    //text[5] = swift;
    text[6] = 13;
    text[7] = 10;
    int count = sizeof(text);
    usb_serial_write(text, count);
}

void main() {
    IOMUXC_SW_MUX_CTL_PAD_GPIO_B0_03 = 5;
    IOMUXC_SW_PAD_CTL_PAD_GPIO_B0_03 = IOMUXC_PAD_DSE(7);
    IOMUXC_GPR_GPR27 = 0xFFFFFFFF;
    GPIO7_GDIR |= (1 << 3);
    GPIO7_DR_SET = (1 << 3);

    usb_pll_start();
    usb_init();

    while(1) {
        write();
        delay(1000);
        //GPIO7_DR_SET = (1 << 3);
        //delay(1000);
        //GPIO7_DR_CLEAR = (1 << 3);
        //delay(1000);
    }
}