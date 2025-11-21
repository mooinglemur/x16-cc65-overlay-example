# cc65 Overlay example (for the Commander X16)

This is a simple example that mixes cc65/ca65 C and assembly lanugage in an unusual way.

The linker config drops the (non-inclusive) end of the main program space down from $9F00 to $9000, and defines three new overlapping memory regions at $9000.

In addition to this, a set of segments is defined to live in each of the three new memory regions.  Due to the way that the cc65 linker (ld65) works, if you have overlapping memory regions that you wish to use in separate contexts for code and data, you must declare each of them in your linker config, and create separately-named segments for each individual use.

Those who write code for NES mappers will already be familiar with this, as well as those who have written cartridge and other code that needs to live in the X16's RAM and/or ROM banks.

However, this example mixes in the concept of calling C functions from assembly code.  Usually, things are done in reverse, where C calls asm functions, but there's nothing precluding going in the other direction if you're aware of how C calls work.

Due to how C needs to initalize its own state, the entry point into this program is via `main()` in C rather than an assembly function.  We **must** allow C to initialize its state (mainly the call stack pointer) before we call any C functions.

The `main()` in this example simply calls our assembly entry point, but it conveniently has an implicit call to the C library's init before calling our asm routine.

The asm routine calls into C several times.  It also demonstrates loading files from disk containing machine language code generated from C source to a predefined location.  There are 3 C functions that are called this way, each one being a slightly different function.

Each of them take only one parameter in order to simplify things (the fastcall method uses the A and X registers and a ZP temp variable for parameter passing for a single argument).


See `build.sh` for how to compile/assemble/link
