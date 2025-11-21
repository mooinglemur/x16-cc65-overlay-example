#include <conio.h>

#pragma code-name ("OVERLAY3")
#pragma data-name ("OVERLAY3DATA")
#pragma rodata-name ("OVERLAY3RODATA")

void __fastcall__ overlay3func(long number) {
	cprintf("I am in OVERLAY3, my function address is 0x%04X, and my parameter is %ld\r\n", &overlay3func, number);
}
