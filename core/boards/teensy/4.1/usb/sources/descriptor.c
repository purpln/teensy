#include "descriptor.h"

const struct usb_string_descriptor_struct usb_string_language = {
    4,
    3,
    {0x0409}
};

const struct usb_string_descriptor_struct usb_string_manufacturer = {
    2 + MANUFACTURER_LEN * 2,
    3,
    MANUFACTURER
};

const struct usb_string_descriptor_struct usb_string_product = {
	2 + PRODUCT_LEN * 2,
    3,
    PRODUCT
};

const struct usb_string_descriptor_struct usb_string_serial_number = {
    2 + SERIAL_NUMBER_LEN * 2,
    3,
    SERIAL_NUMBER
};

static uint8_t device_descriptor[] = {
	18,					// bLength
	1,					// bDescriptorType
	0x00, 0x02,				// bcdUSB
	2,					// bDeviceClass
	0,					// bDeviceSubClass
	0,					// bDeviceProtocol
	ENDPOINT0_SIZE,				// bMaxPacketSize0
	LSB(VENDOR_ID), MSB(VENDOR_ID),		// idVendor
	LSB(PRODUCT_ID), MSB(PRODUCT_ID),	// idProduct
	0x02, 0x01,				// bcdDevice
	1,					// iManufacturer
	2,					// iProduct
	3,					// iSerialNumber
	1					// bNumConfigurations
};

static const uint8_t qualifier_descriptor[10] = {	// 9.6.2 Device_Qualifier, page 264
	10,					// bLength
	6,					// bDescriptorType
	0x00, 0x02,				// bcdUSB
	0,                      // bDeviceClass
	0,                    // bDeviceSubClass
	0,                // bDeviceProtocol
    ENDPOINT0_SIZE,                               // bMaxPacketSize0
    1,					// bNumConfigurations
    0                                       // bReserved
};

#ifdef EXPERIMENTAL_INTERFACE
static uint8_t microsoft_os_string_desc[] = {
	18, 3,
	'M', 0, 'S', 0, 'F', 0, 'T', 0, '1', 0, '0', 0, '0', 0,
	0xF8, 0  // GET_MS_DESCRIPTOR will use bRequest=0xF8
};
static uint8_t microsoft_os_compatible_id_desc[] = {
	40, 0, 0, 0, // total length, 16 header + 24 function * 1
	0, 1, 4, 0,  // version 1.00, wIndex=4 (Compat ID)
	1, 0, 0, 0, 0, 0, 0, 0, // 1 function
	EXPERIMENTAL_INTERFACE, 1,
	'W','I','N','U','S','B',0,0, // compatibleID
	0,0,0,0,0,0,0,0,             // subCompatibleID
	0,0,0,0,0,0
};
#endif

extern const uint8_t usb_config_descriptor_12[CONFIG_DESC_SIZE];
extern const uint8_t usb_config_descriptor_480[CONFIG_DESC_SIZE];

const usb_descriptor_list_t usb_descriptor_list[] = {
	{0x0100, 0x0000, device_descriptor, sizeof(device_descriptor)},
	{0x0600, 0x0000, qualifier_descriptor, sizeof(qualifier_descriptor)},
    //{0x0200, 0x0000, config_descriptor, sizeof(config_descriptor)},
	{0x0200, 0x0000, usb_config_descriptor_480, CONFIG_DESC_SIZE},
	{0x0700, 0x0000, usb_config_descriptor_12, CONFIG_DESC_SIZE},
#ifdef EXPERIMENTAL_INTERFACE
	{0x03EE, 0x0000, microsoft_os_string_desc, 18},
	{0x0000, 0xEE04, microsoft_os_compatible_id_desc, 40},
#endif
    {0x0300, 0x0000, (const uint8_t *)&usb_string_language, 4},
    {0x0301, 0x0409, (const uint8_t *)&usb_string_manufacturer, 16},
    {0x0302, 0x0409, (const uint8_t *)&usb_string_product, 16},
    {0x0303, 0x0409, (const uint8_t *)&usb_string_serial_number, 16},
	{0, 0, NULL, 0}
};

//__attribute__((section(".progmem")))
const uint8_t usb_config_descriptor_480[CONFIG_DESC_SIZE] = {
        // configuration descriptor, USB spec 9.6.3, page 264-266, Table 9-10
        9,                                      // bLength;
        2,                                      // bDescriptorType;
        LSB(CONFIG_DESC_SIZE),                  // wTotalLength
        MSB(CONFIG_DESC_SIZE),
        NUM_INTERFACE,                          // bNumInterfaces
        1,                                      // bConfigurationValue
        0,                                      // iConfiguration
        0xC0,                                   // bmAttributes
        50,                                     // bMaxPower
        // interface association descriptor, USB ECN, Table 9-Z
        8,                                      // bLength
        11,                                     // bDescriptorType
        CDC_STATUS_INTERFACE,                   // bFirstInterface
        2,                                      // bInterfaceCount
        0x02,                                   // bFunctionClass
        0x02,                                   // bFunctionSubClass
        0x01,                                   // bFunctionProtocol
        0,                                      // iFunction
	// configuration for 480 Mbit/sec speed
        // interface descriptor, USB spec 9.6.5, page 267-269, Table 9-12
        9,                                      // bLength
        4,                                      // bDescriptorType
        CDC_STATUS_INTERFACE,			        // bInterfaceNumber
        0,                                      // bAlternateSetting
        1,                                      // bNumEndpoints
        0x02,                                   // bInterfaceClass
        0x02,                                   // bInterfaceSubClass
        0x01,                                   // bInterfaceProtocol
        0,                                      // iInterface
        // CDC Header Functional Descriptor, CDC Spec 5.2.3.1, Table 26
        5,                                      // bFunctionLength
        0x24,                                   // bDescriptorType
        0x00,                                   // bDescriptorSubtype
        0x10, 0x01,                             // bcdCDC
        // Call Management Functional Descriptor, CDC Spec 5.2.3.2, Table 27
        5,                                      // bFunctionLength
        0x24,                                   // bDescriptorType
        0x01,                                   // bDescriptorSubtype
        0x01,                                   // bmCapabilities
        1,                                      // bDataInterface
        // Abstract Control Management Functional Descriptor, CDC Spec 5.2.3.3, Table 28
        4,                                      // bFunctionLength
        0x24,                                   // bDescriptorType
        0x02,                                   // bDescriptorSubtype
        0x06,                                   // bmCapabilities
        // Union Functional Descriptor, CDC Spec 5.2.3.8, Table 33
        5,                                      // bFunctionLength
        0x24,                                   // bDescriptorType
        0x06,                                   // bDescriptorSubtype
        CDC_STATUS_INTERFACE,                   // bMasterInterface
        CDC_DATA_INTERFACE,                     // bSlaveInterface0
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        CDC_ACM_ENDPOINT | 0x80,                // bEndpointAddress
        0x03,                                   // bmAttributes (0x03=intr)
        LSB(CDC_ACM_SIZE),MSB(CDC_ACM_SIZE),    // wMaxPacketSize
        5,                                      // bInterval
        // interface descriptor, USB spec 9.6.5, page 267-269, Table 9-12
        9,                                      // bLength
        4,                                      // bDescriptorType
        CDC_DATA_INTERFACE,                     // bInterfaceNumber
        0,                                      // bAlternateSetting
        2,                                      // bNumEndpoints
        0x0A,                                   // bInterfaceClass
        0x00,                                   // bInterfaceSubClass
        0x00,                                   // bInterfaceProtocol
        0,                                      // iInterface
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        CDC_RX_ENDPOINT,                        // bEndpointAddress
        0x02,                                   // bmAttributes (0x02=bulk)
        LSB(CDC_RX_SIZE_480),MSB(CDC_RX_SIZE_480),// wMaxPacketSize
        0,                                      // bInterval
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        CDC_TX_ENDPOINT | 0x80,                 // bEndpointAddress
        0x02,                                   // bmAttributes (0x02=bulk)
        LSB(CDC_TX_SIZE_480),MSB(CDC_TX_SIZE_480),// wMaxPacketSize
        0,
#ifdef EXPERIMENTAL_INTERFACE
	// configuration for 480 Mbit/sec speed
        // interface descriptor, USB spec 9.6.5, page 267-269, Table 9-12
        9,                                      // bLength
        4,                                      // bDescriptorType
        EXPERIMENTAL_INTERFACE,                 // bInterfaceNumber
        0,                                      // bAlternateSetting
        2,                                      // bNumEndpoints
        0xFF,                                   // bInterfaceClass (0xFF = Vendor)
        0x6A,                                   // bInterfaceSubClass
        0xC7,                                   // bInterfaceProtocol
        0,                                      // iInterface
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        1 | 0x80,                               // bEndpointAddress
        0x02,                                   // bmAttributes (0x02=bulk)
        LSB(512), MSB(512),                     // wMaxPacketSize
        1,                                      // bInterval
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        1,                                      // bEndpointAddress
        0x02,                                   // bmAttributes (0x02=bulk)
        LSB(512), MSB(512),                     // wMaxPacketSize
        1,                                      // bInterval
#endif // EXPERIMENTAL_INTERFACE
};

//__attribute__((section(".progmem")))
const uint8_t usb_config_descriptor_12[CONFIG_DESC_SIZE] = {
        // configuration descriptor, USB spec 9.6.3, page 264-266, Table 9-10
        9,                                      // bLength;
        2,                                      // bDescriptorType;
        LSB(CONFIG_DESC_SIZE),                 // wTotalLength
        MSB(CONFIG_DESC_SIZE),
        NUM_INTERFACE,                          // bNumInterfaces
        1,                                      // bConfigurationValue
        0,                                      // iConfiguration
        0xC0,                                   // bmAttributes
        50,                                     // bMaxPower
        // interface association descriptor, USB ECN, Table 9-Z
        8,                                      // bLength
        11,                                     // bDescriptorType
        CDC_STATUS_INTERFACE,                   // bFirstInterface
        2,                                      // bInterfaceCount
        0x02,                                   // bFunctionClass
        0x02,                                   // bFunctionSubClass
        0x01,                                   // bFunctionProtocol
        0,                                      // iFunction
	    // configuration for 12 Mbit/sec speed
        // interface descriptor, USB spec 9.6.5, page 267-269, Table 9-12
        9,                                      // bLength
        4,                                      // bDescriptorType
        CDC_STATUS_INTERFACE,			// bInterfaceNumber
        0,                                      // bAlternateSetting
        1,                                      // bNumEndpoints
        0x02,                                   // bInterfaceClass
        0x02,                                   // bInterfaceSubClass
        0x01,                                   // bInterfaceProtocol
        0,                                      // iInterface
        // CDC Header Functional Descriptor, CDC Spec 5.2.3.1, Table 26
        5,                                      // bFunctionLength
        0x24,                                   // bDescriptorType
        0x00,                                   // bDescriptorSubtype
        0x10, 0x01,                             // bcdCDC
        // Call Management Functional Descriptor, CDC Spec 5.2.3.2, Table 27
        5,                                      // bFunctionLength
        0x24,                                   // bDescriptorType
        0x01,                                   // bDescriptorSubtype
        0x01,                                   // bmCapabilities
        1,                                      // bDataInterface
        // Abstract Control Management Functional Descriptor, CDC Spec 5.2.3.3, Table 28
        4,                                      // bFunctionLength
        0x24,                                   // bDescriptorType
        0x02,                                   // bDescriptorSubtype
        0x06,                                   // bmCapabilities
        // Union Functional Descriptor, CDC Spec 5.2.3.8, Table 33
        5,                                      // bFunctionLength
        0x24,                                   // bDescriptorType
        0x06,                                   // bDescriptorSubtype
        CDC_STATUS_INTERFACE,                   // bMasterInterface
        CDC_DATA_INTERFACE,                     // bSlaveInterface0
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        CDC_ACM_ENDPOINT | 0x80,                // bEndpointAddress
        0x03,                                   // bmAttributes (0x03=intr)
        CDC_ACM_SIZE, 0,                        // wMaxPacketSize
        16,                                     // bInterval
        // interface descriptor, USB spec 9.6.5, page 267-269, Table 9-12
        9,                                      // bLength
        4,                                      // bDescriptorType
        CDC_DATA_INTERFACE,                     // bInterfaceNumber
        0,                                      // bAlternateSetting
        2,                                      // bNumEndpoints
        0x0A,                                   // bInterfaceClass
        0x00,                                   // bInterfaceSubClass
        0x00,                                   // bInterfaceProtocol
        0,                                      // iInterface
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        CDC_RX_ENDPOINT,                        // bEndpointAddress
        0x02,                                   // bmAttributes (0x02=bulk)
        LSB(CDC_RX_SIZE_12),MSB(CDC_RX_SIZE_12),// wMaxPacketSize
        0,                                      // bInterval
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        CDC_TX_ENDPOINT | 0x80,                 // bEndpointAddress
        0x02,                                   // bmAttributes (0x02=bulk)
        LSB(CDC_TX_SIZE_12),MSB(CDC_TX_SIZE_12),// wMaxPacketSize
        0,                                      // bInterval
#ifdef EXPERIMENTAL_INTERFACE
	// configuration for 12 Mbit/sec speed
        // interface descriptor, USB spec 9.6.5, page 267-269, Table 9-12
        9,                                      // bLength
        4,                                      // bDescriptorType
        EXPERIMENTAL_INTERFACE,                 // bInterfaceNumber
        0,                                      // bAlternateSetting
        2,                                      // bNumEndpoints
        0xFF,                                   // bInterfaceClass (0xFF = Vendor)
        0x6A,                                   // bInterfaceSubClass
        0xFF,                                   // bInterfaceProtocol
        0,                                      // iInterface
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        1 | 0x80,                               // bEndpointAddress
        0x02,                                   // bmAttributes (0x02=bulk)
        LSB(64), MSB(64),                       // wMaxPacketSize
        1,                                      // bInterval
        // endpoint descriptor, USB spec 9.6.6, page 269-271, Table 9-13
        7,                                      // bLength
        5,                                      // bDescriptorType
        1,                                      // bEndpointAddress
        0x02,                                   // bmAttributes (0x02=bulk)
        LSB(64), MSB(64),                       // wMaxPacketSize
        1,                                      // bInterval
#endif // EXPERIMENTAL_INTERFACE
};

//9 + 8 + 9 + 5 + 5 + 4 + 5 + 7 + 9 + 7 + 7
//9 + 7 + 7