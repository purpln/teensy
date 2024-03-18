#include "math.h"

#if defined(__arm) || defined(__arm__)

typedef struct {
    unsigned long long quot;
    unsigned long long rem;
} ulldiv_t;

static uint64_t __aeabi_uldivmod_recursive(uint64_t dividend, uint64_t divisor, uint64_t acc);

static int is_power_of2(uint32_t n) {
	return (n && !(n & (n - 1)));
}

static int get_power_of2(uint32_t n) {
	int i;
	for (i = 0; i < sizeof(uint32_t)*8; i++) {
		if (n & 0x1) {
			return i;
		} else {
			n = n >> 1;
		}
	}
	//if we get here, then n was 0. return error
	return -1;
}

ulldiv_t __aeabi_uldivmod(uint64_t dividend, uint64_t divisor) {
	ulldiv_t ret;
	
	if (divisor == 0) {
		//assert(0, "Divide by 0!");
	}
	if (dividend < divisor) {
		ret.quot = 0;
		ret.rem = dividend;
		return ret;
	}
	
	/* check if divisor is a power of 2 */
	if (is_power_of2(divisor)) {
		// this func call just returns a number of bits, no need for ull
		ret.quot = dividend >> get_power_of2(divisor);
		ret.rem = dividend - ret.quot * divisor;
		return ret;
	}
	
	ret.quot = __aeabi_uldivmod_recursive(dividend, divisor, 0);
	ret.rem = dividend - ret.quot * divisor;
	return ret;
}

static uint64_t __aeabi_uldivmod_recursive(uint64_t dividend, uint64_t divisor, uint64_t acc) {
	if (dividend < divisor) {
		return acc;
	}
	
	uint64_t res = 1, tmp = divisor;
	
	while (dividend > tmp) {
		/* we need to be careful here that we don't shift past the last bit */
		if (tmp & (1ULL << (sizeof(uint64_t)*8-1))) {
			break;
		}
		
		tmp = tmp << 1;
		if (tmp > dividend) {
			tmp = tmp >> 1; //shift it back for later
			break;
		}
		res *= 2;
	}
	
	return __aeabi_uldivmod_recursive(dividend - tmp, divisor, acc + res);
}


#endif /* __arm || __arm__ */