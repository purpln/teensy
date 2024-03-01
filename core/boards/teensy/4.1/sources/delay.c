#include <stdint.h>
#include "board.h"
#include "delay.h"

volatile uint32_t SYSTICK_EXT_FREQ = 100000;

volatile uint32_t systick_millis_count = 0;
volatile uint32_t systick_cycle_count = 0;
volatile uint32_t scale_cpu_cycles_to_microseconds = 0;
uint32_t systick_safe_read;	 // micros() synchronization

uint32_t millis(void) {
	return systick_millis_count;
}

uint32_t __STREXW(uint32_t value, volatile uint32_t *addr) {
   uint32_t result;

   asm volatile ("strex %0, %2, %1" : "=&r" (result), "=Q" (*addr) : "r" (value) );
   return(result);
}

uint32_t __LDREXW(volatile uint32_t *addr) {
    uint32_t result;

   asm volatile ("ldrex %0, %1" : "=r" (result) : "Q" (*addr) );
   return(result);
}

//The 24 MHz XTALOSC can be the external clock source of SYSTICK. 
//Hardware devides this down to 100KHz. (RM Rev2, 13.3.21 PG 986)

void systick_isr(void) {
	systick_millis_count++;
}

void yield(void) {}

// Wait for a number of milliseconds.  During this time, interrupts remain
// active, but the rest of your program becomes effectively stalled.  Usually
// delay() is used in very simple programs.  To achieve delay without waiting
// use millis() or elapsedMillis.  For shorter delay, use delayMicroseconds()
// or delayNanoseconds().
void delay(uint32_t msec) {
	uint32_t start;

	if (msec == 0) return;
	start = micros();
	while (1) {
		while ((micros() - start) >= 1000) {
			if (--msec == 0) return;
			start += 1000;
		}
		yield();
	}
	// TODO...
}

// Returns the number of microseconds since your program started running.
// This 32 bit number will roll back to zero after about 71 minutes and
// 35 seconds.  For a simpler way to build delays or timeouts, consider
// using elapsedMicros.
uint32_t micros(void) {
	uint32_t smc, scc;
	do {
		__LDREXW(&systick_safe_read);
		smc = systick_millis_count;
		scc = systick_cycle_count;
	} while ( __STREXW(1, &systick_safe_read));
	uint32_t cyccnt = ARM_DWT_CYCCNT;
	asm volatile("" : : : "memory");
	uint32_t ccdelta = cyccnt - scc;
	uint32_t frac = ((uint64_t)ccdelta * scale_cpu_cycles_to_microseconds) >> 32;
	if (frac > 1000) frac = 1000;
	uint32_t usec = 1000*smc + frac;
	return usec;
}
