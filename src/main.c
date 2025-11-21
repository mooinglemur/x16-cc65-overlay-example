#include <conio.h>

extern void __fastcall__ start(void);

// Library functions in main RAM

void __fastcall__ print_message(const char *msg) {
	cprintf("%s", msg);
}

// Main entry point is in C because
// we need C to initialize its own state
// before we can call C functions.

// But we jump right into our ASM code
// afterwards. :)

void main(void) {
	start(); // calls assembly routine
}
