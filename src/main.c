#include <conio.h>

extern void __fastcall__ start(void);

// Library functions in main RAM

void __fastcall__ print_message(const char *msg) {
	cprintf("%s", msg);
}

// Main entry point has to be in C because
// C does some initialization for its own state
// that we can't reach if we were to start in ASM

void main(void) {
	start(); // calls assembly routine
}
