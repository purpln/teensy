#include <stdio.h>
#include <stdlib.h>
#include <board.h>
#include <stdatomic.h>
#include <delay.h>
#include <usb.h>
#include <serial.h>
#include <wchar.h>

extern long addition(long, long);
extern long subtraction(long, long);
extern long multiplication(long, long);
extern long division(long, long);
extern long compare(long, long);
extern long less(long, long);
extern long greater(long, long);

extern double test(double, double);
extern void main();

void transform(float x, char *p) {
    char *s = p + 10; // go to end of buffer
    uint16_t decimals;  // variable to store the decimals
    int units;  // variable to store the units (part to left of decimal place)
    if (x < 0) { // take care of negative numbers
        decimals = (int)(x * -100) % 100; // make 1000 for 3 decimals etc.
        units = (int)(-1 * x);
    } else { // positive numbers
        decimals = (int)(x * 100) % 100;
        units = (int)x;
    }

    *--s = (decimals % 10) + '0';
    decimals /= 10; // repeat for as many decimal places as you need
    *--s = (decimals % 10) + '0';
    *--s = '.';

    while (units > 0) {
        *--s = (units % 10) + '0';
        units /= 10;
    }
    if (x < 0) *--s = '-'; // unary minus sign for negative numbers
}

void write() {
    main();
    //long integer = addition(40, 2);
    double floating = test(0.4, 0.02);
    char text[12] = "          \r\n";

    //itoa(integer, text, 10);
    transform((float)floating, text);
    
    usb_serial_write(text, sizeof(text));
}

void entry() {
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