#pragma once

#include <stdint.h>
#include <wchar.h>
#include <board.h>

#define ENDPOINT_TRANSMIT_UNUSED	0x00020000
#define ENDPOINT_TRANSMIT_ISOCHRONOUS	0x00C40000
#define ENDPOINT_TRANSMIT_BULK		0x00C80000
#define ENDPOINT_TRANSMIT_INTERRUPT	0x00CC0000
#define ENDPOINT_RECEIVE_UNUSED		0x00000002
#define ENDPOINT_RECEIVE_ISOCHRONOUS	0x000000C4
#define ENDPOINT_RECEIVE_BULK		0x000000C8
#define ENDPOINT_RECEIVE_INTERRUPT	0x000000CC

#define VENDOR_ID		0x16C0
#define PRODUCT_ID		0x0483
#define MANUFACTURER	    {'t','e','e','n','s','y',0}
#define MANUFACTURER_LEN	7
#define PRODUCT		        {'s','e','r','i','a','l',0}
#define PRODUCT_LEN	        7
#define SERIAL_NUMBER		{'n','u','m','b','e','r',0}
#define SERIAL_NUMBER_LEN	7

#define ENDPOINT0_SIZE          64
#define NUM_ENDPOINTS		4
#define NUM_USB_BUFFERS	12
#define NUM_INTERFACE		3
#define CDC_IAD_DESCRIPTOR    1       // Serial
#define CDC_STATUS_INTERFACE	0
#define CDC_DATA_INTERFACE	1
#define CDC_ACM_ENDPOINT	2
#define CDC_RX_ENDPOINT       3
#define CDC_TX_ENDPOINT       4
#define CDC_ACM_SIZE          16
#define CDC_RX_SIZE_480       512
#define CDC_TX_SIZE_480       512
#define CDC_RX_SIZE_12        64
#define CDC_TX_SIZE_12        64
#define EXPERIMENTAL_INTERFACE 2
#define ENDPOINT2_CONFIG	ENDPOINT_RECEIVE_UNUSED + ENDPOINT_TRANSMIT_INTERRUPT
#define ENDPOINT3_CONFIG	ENDPOINT_RECEIVE_BULK + ENDPOINT_TRANSMIT_UNUSED
#define ENDPOINT4_CONFIG      ENDPOINT_RECEIVE_UNUSED + ENDPOINT_TRANSMIT_BULK

#ifdef  EXPERIMENTAL_INTERFACE
#define EXPERIMENTAL_INTERFACE_DESC_SIZE 9+7+7
#else
#define EXPERIMENTAL_INTERFACE_DESC_SIZE 0
#endif

#define CONFIG_DESC_SIZE (9 + 8 + 9 + 5 + 5 + 4 + 5 + 7 + 9 + 7 + 7) + EXPERIMENTAL_INTERFACE_DESC_SIZE

#define LSB(n) (n & 255)
#define MSB(n) ((n >> 8) & 255)

struct usb_string_descriptor_struct {
	uint8_t bLength;
	uint8_t bDescriptorType;
	int16_t wString[];
};

typedef struct {
	uint16_t	wValue;
	uint16_t	wIndex;
	const uint8_t	*addr;
	uint16_t	length;
} usb_descriptor_list_t;