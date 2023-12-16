#pragma once

#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <wchar.h>
#include <board.h>
#include <delay.h>
#include "usb.h"
#include "descriptor.h"

#ifdef __cplusplus
extern "C" {
#endif
void usb_serial_reset(void);
void usb_serial_configure(void);
int usb_serial_getchar(void);
int usb_serial_peekchar(void);
int usb_serial_available(void);
int usb_serial_read(void *buffer, uint32_t size);
void usb_serial_flush_input(void);
int usb_serial_putchar(uint8_t c);
int usb_serial_write(const void *buffer, uint32_t size);
int usb_serial_write_buffer_free(void);
void usb_serial_flush_output(void);
extern uint32_t usb_cdc_line_coding[2];
extern volatile uint32_t usb_cdc_line_rtsdtr_millis;
extern volatile uint32_t systick_millis_count;
extern volatile uint8_t usb_cdc_line_rtsdtr;
extern volatile uint8_t usb_cdc_transmit_flush_timer;
extern volatile uint8_t usb_configuration;
#ifdef __cplusplus
}
#endif