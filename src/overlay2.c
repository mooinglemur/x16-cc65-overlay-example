#include <conio.h>

#pragma code-name ("OVERLAY2")
#pragma data-name ("OVERLAY2DATA")
#pragma rodata-name ("OVERLAY2RODATA")

void __fastcall__ overlay2func(unsigned char ch) {
	cprintf("I am in OVERLAY2, my function address is 0x%04X, and my parameter is %c\r\n", &overlay2func, ch);
}
