#pragma once

#define SWIFT_RUNTIME_ABI __attribute__((__visibility__("default")))

/*
#if defined(__ELF__)
#define SWIFT_RUNTIME_ABI __attribute__((__visibility__("default")))
#elif defined(__MACH__)
#define SWIFT_RUNTIME_ABI __attribute__((__visibility__("default")))
#elif defined(__WASM__)
#define SWIFT_RUNTIME_ABI __attribute__((__visibility__("default")))
#else
#define SWIFT_RUNTIME_ABI __declspec(dllexport)
#endif
*/
