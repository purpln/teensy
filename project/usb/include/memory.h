#pragma once

#include <stdint.h>
#include <stddef.h>
#include <board.h>
#include "descriptor.h"

typedef struct usb_packet_struct {
	uint16_t len;
	uint16_t index;
	struct usb_packet_struct *next;
	uint8_t buf[64];
} usb_packet_t;

#ifdef __cplusplus
extern "C" {
#endif

usb_packet_t * usb_malloc(void);
void usb_free(usb_packet_t *p);

usb_packet_t *usb_rx(uint32_t endpoint);
void usb_tx(uint32_t endpoint, usb_packet_t *packet);

extern volatile uint8_t usb_configuration;

#ifdef __cplusplus
}
#endif