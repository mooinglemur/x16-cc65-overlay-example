; KERNAL calls

CHROUT := $FFD2
SETNAM := $FFBD
SETLFS := $FFBA
LOAD   := $FFD5

.segment "ZEROPAGE"
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

; symbols in C have a leading underscore on the asm side
.import _print_message
.import _overlay1func
.import _overlay2func
.import _overlay3func

; for fastcall
.importzp sreg

overlayfunc := _overlay1func ; these three functions should all be in the same place, right?
.assert _overlay1func = _overlay2func, error, "Overlay functions aren't at the same address"
.assert _overlay1func = _overlay3func, error, "Overlay functions aren't at the same address"

.export _start

_start:
	; This file and the entry point is basically like a regular ca65 ASM project
	; except our main entry point is in C and then C calls this function

	; let's use C to print a message using the fastcall parameter passing method
	lda #<message1
	ldx #>message1

	; void __fastcall__ print_message(const char *msg);
	jsr _print_message

	; let's load OVERLAY1.BIN, self-mod the filename
	lda #'1'
	sta overlaynum

	ldx #<overlayfn
	ldy #>overlayfn
	lda #(overlayfn_end-overlayfn)

	jsr SETNAM

	lda #1
	ldx #8
	ldy #2

	jsr SETLFS

	ldx #<overlayfunc
	ldy #>overlayfunc
	lda #0

	jsr LOAD

	; let's load a short number via fastcall
	lda #<1337
	ldx #>1337

	; void __fastcall__ overlay1func(short count);
	jsr overlayfunc ; we could use any of the symbols that point to this address

	; let's load OVERLAY2.BIN, self-mod the filename
	inc overlaynum

	ldx #<overlayfn
	ldy #>overlayfn
	lda #(overlayfn_end-overlayfn)

	jsr SETNAM

	lda #1
	ldx #8
	ldy #2

	jsr SETLFS

	ldx #<overlayfunc
	ldy #>overlayfunc
	lda #0

	jsr LOAD

	; let's load a character via fastcall
	lda #'@'

	; void __fastcall__ overlay2func(char ch);
	jsr overlayfunc

	; let's load OVERLAY3.BIN, self-mod the filename
	inc overlaynum

	ldx #<overlayfn
	ldy #>overlayfn
	lda #(overlayfn_end-overlayfn)

	jsr SETNAM

	lda #1
	ldx #8
	ldy #2

	jsr SETLFS

	ldx #<overlayfunc
	ldy #>overlayfunc
	lda #0

	jsr LOAD

	; long value via fastcall uses AX for low 16 bits and sreg for the upper 16
	; constants in ca65 are always evaluated as 32 bits
	BIGASSNUMBER = 123456789
	lda #<.hiword(BIGASSNUMBER)
	sta sreg
	lda #>.hiword(BIGASSNUMBER)
	sta sreg+1
	lda #<BIGASSNUMBER
	ldx #>BIGASSNUMBER

	; void __fastcall__ overlay3func(long number);
	jsr overlayfunc

	rts


.segment "RODATA"
message1:
	; keep in mind that most string literals in this project are
	; translated to PETSCII during assembly and compilation
	.byte "Hello World!",13,10,0 ; we null-terminate our strings

overlayfn:
	.byte "overlay"
overlaynum:
	.byte "x"
overlayext:
	.byte ".bin" ; filenames are PETSCII-mangled too, this is in reality uppercase ASCII
overlayfn_end:
