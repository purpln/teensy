#include <stdint.h>

uint64_t __atomic_load_8(volatile void *mem, int model) {
	uint64_t ret = *((uint64_t *) mem);
	return ret;
}

void __atomic_store_8(volatile void *mem, uint64_t val, int model) {
	*((uint64_t *) mem) = val;
	return;
}