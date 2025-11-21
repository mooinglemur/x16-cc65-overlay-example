#include <conio.h>

#pragma code-name ("OVERLAY3")
#pragma rodata-name ("OVERLAY3DATA")
#pragma data-name ("OVERLAY3DATA")

void __fastcall__ overlay3func(long number) {
	cprintf("I am in OVERLAY3, my function address is 0x%04X, and my parameter is %ld\r\n", &overlay3func, number);
}
