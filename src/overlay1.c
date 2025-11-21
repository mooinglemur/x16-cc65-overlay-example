#include <conio.h>

#pragma code-name ("OVERLAY1")
#pragma rodata-name ("OVERLAY1DATA")
#pragma data-name ("OVERLAY1DATA")

void __fastcall__ overlay1func(short count) {
	cprintf("I am in OVERLAY1, my function address is 0x%04X, and my parameter is %d\r\n", &overlay1func, count);
}

