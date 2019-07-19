section .text
global ctfftf

ctfftf:
	push	ebx
	push	edi
	push	esi

	mov	edi		, [esp + 16]
	mov	esi		, [esp + 20]

	mov	eax		, edi
	mov	ebx		, edi
	mov	ecx		, edi
	mov	edx		, esi

	sub	edx		, edi
	shr	edx		, 4
	mov	[esp - 4]	, edx

	fldpi					; 				pi
	fchs					; 				-pi
	fidiv	dword [esp - 4]			; 				dta
	fldz					; 			ta	dta
	fldz					; 		ti	ta	dta
	fld1					; 	tr	ti	ta	dta

	shl	edx		, 3
	sub	esi		, edx
	sub	esi		, 8

	jmp	.begin

.twiddle:

	fld ST0					; 			dta	dta
	faddp					; 				dta'
	fldz					;			0	dta
	fldz					;		0	0	dta
	fld1					;	1	0	0	dta

	add	eax		, 8
	mov	ebx		, edi
	mov	ecx		, edi
	shr	edx		, 1
	add	esi		, edx

	jmp	.begin

.rewind:

	fadd	ST0		, ST1		; 			ta'	dta
	fld	ST0				; 		ta	ta	dta
	fsincos					; 	tr	ti	ta	dta

	add	eax		, 8
	add	ebx		, 8
	mov	ecx		, ebx

	jmp	.begin

.next:
	
	lea	ecx		, [ecx + edx * 2]

.begin:

	fld	dword [ecx]			;				ar
	fld	ST0				;			ar	ar
	fld	dword [ecx + edx]		;		br	ar	ar
	fsub	ST2		, ST0		;		br	ar	bbr
	faddp					;			aar	bbr
	fstp	dword [ecx]			;				bbr

	fld	dword [ecx + 4]			;			ai	bbr
	fld	ST0				;		ai	ai	bbr
	fld	dword [ecx + edx + 4]		;	bi	ai	ai	bbr
	fsub	ST2		, ST0		;	bi	ai	bbi	bbr
	faddp					;		aai	bbi	bbr
	fstp	dword [ecx + 4]			;			bbi	bbr

	fld	ST1				;		bbr	bbi	bbr
	fmul	ST0		, ST4		;		tibbr	bbi	bbr
	fld	ST1				;	bbi	tibbr	bbi	bbr
	fmul	ST0		, ST4		;	trbbi	tibbr	bbi	bbr
	faddp					;		bbbi	bbi	bbr
	fstp	dword [ecx + edx + 4]		;			bbi	bbr

	fmul	ST0		, ST3		;			tibbi	bbr
	fxch					;			bbr	tibbi
	fmul	ST0		, ST2		;			trbbr	tibbi
	fsubrp					;				bbbr
	fstp	dword [ecx + edx]		;

	cmp	ecx		, eax
	jne	.next

	fstp	ST0				; 		ti	ta	dta
	fstp	ST0				; 			ta	dta

	cmp	eax		, esi
	jne	.rewind

	fstp	ST0				; 				dta

	cmp	edx		, 8
	jne	.twiddle

	fstp	ST0				; 				

	pop	esi
	pop	edi
	pop	ebx

	ret

global ctfftd

ctfftd:
	push	ebx
	push	edi
	push	esi

	mov	edi		, [esp + 16]
	mov	esi		, [esp + 20]

	mov	eax		, edi
	mov	ebx		, edi
	mov	ecx		, edi
	mov	edx		, esi

	sub	edx		, edi
	shr	edx		, 5
	mov	[esp - 4]	, edx

	fldpi					; 				pi
	fchs					; 				-pi
	fidiv	dword [esp - 4]			; 				dta
	fldz					; 			ta	dta
	fldz					; 		ti	ta	dta
	fld1					; 	tr	ti	ta	dta

	shl	edx		, 4
	sub	esi		, edx
	sub	esi		, 16

	jmp	.begin

.twiddle:

	fld ST0					; 			dta	dta
	faddp					; 				dta'
	fldz					;			0	dta
	fldz					;		0	0	dta
	fld1					;	1	0	0	dta

	add	eax		, 16
	mov	ebx		, edi
	mov	ecx		, edi
	shr	edx		, 1
	add	esi		, edx

	jmp	.begin

.rewind:

	fadd	ST0		, ST1		; 			ta'	dta
	fld	ST0				; 		ta	ta	dta
	fsincos					; 	tr	ti	ta	dta

	add	eax		, 16
	add	ebx		, 16
	mov	ecx		, ebx

	jmp	.begin

.next:
	
	lea	ecx		, [ecx + edx * 2]

.begin:

	fld	qword [ecx]			;				ar
	fld	ST0				;			ar	ar
	fld	qword [ecx + edx]		;		br	ar	ar
	fsub	ST2		, ST0		;		br	ar	bbr
	faddp					;			aar	bbr
	fstp	qword [ecx]			;				bbr

	fld	qword [ecx + 8]			;			ai	bbr
	fld	ST0				;		ai	ai	bbr
	fld	qword [ecx + edx + 8]		;	bi	ai	ai	bbr
	fsub	ST2		, ST0		;	bi	ai	bbi	bbr
	faddp					;		aai	bbi	bbr
	fstp	qword [ecx + 8]			;			bbi	bbr

	fld	ST1				;		bbr	bbi	bbr
	fmul	ST0		, ST4		;		tibbr	bbi	bbr
	fld	ST1				;	bbi	tibbr	bbi	bbr
	fmul	ST0		, ST4		;	trbbi	tibbr	bbi	bbr
	faddp					;		bbbi	bbi	bbr
	fstp	qword [ecx + edx + 8]		;			bbi	bbr

	fmul	ST0		, ST3		;			tibbi	bbr
	fxch					;			bbr	tibbi
	fmul	ST0		, ST2		;			trbbr	tibbi
	fsubrp					;				bbbr
	fstp	qword [ecx + edx]		;

	cmp	ecx		, eax
	jne	.next

	fstp	ST0				; 		ti	ta	dta
	fstp	ST0				; 			ta	dta

	cmp	eax		, esi
	jne	.rewind

	fstp	ST0				; 				dta

	cmp	edx		, 16
	jne	.twiddle

	fstp	ST0				; 				

	pop	esi
	pop	edi
	pop	ebx

	ret

global ctfftl

ctfftl:
	push	ebx
	push	edi
	push	esi

	mov	edi		, [esp + 16]
	mov	esi		, [esp + 20]

	mov	eax		, edi
	mov	ebx		, edi
	mov	ecx		, edi
	mov	edx		, esi

	sub	edx		, edi
	shr	edx		, 6
	mov	[esp - 4]	, edx

	fldpi					; 				pi
	fchs					; 				-pi
	fidiv	dword [esp - 4]			; 				dta
	fldz					; 			ta	dta
	fldz					; 		ti	ta	dta
	fld1					; 	tr	ti	ta	dta

	shl	edx		, 5
	sub	esi		, edx
	sub	esi		, 32

	jmp	.begin

.twiddle:

	fld ST0					; 			dta	dta
	faddp					; 				dta'
	fldz					;			0	dta
	fldz					;		0	0	dta
	fld1					;	1	0	0	dta

	add	eax		, 32
	mov	ebx		, edi
	mov	ecx		, edi
	shr	edx		, 1
	add	esi		, edx

	jmp	.begin

.rewind:

	fadd	ST0		, ST1		; 			ta'	dta
	fld	ST0				; 		ta	ta	dta
	fsincos					; 	tr	ti	ta	dta

	add	eax		, 32
	add	ebx		, 32
	mov	ecx		, ebx

	jmp	.begin

.next:
	
	lea	ecx		, [ecx + edx * 2]

.begin:

	fld	tword [ecx]			;				ar
	fld	ST0				;			ar	ar
	fld	tword [ecx + edx]		;		br	ar	ar
	fsub	ST2		, ST0		;		br	ar	bbr
	faddp					;			aar	bbr
	fstp	tword [ecx]			;				bbr

	fld	tword [ecx + 16]		;			ai	bbr
	fld	ST0				;		ai	ai	bbr
	fld	tword [ecx + edx + 16]		;	bi	ai	ai	bbr
	fsub	ST2		, ST0		;	bi	ai	bbi	bbr
	faddp					;		aai	bbi	bbr
	fstp	tword [ecx + 16]		;			bbi	bbr

	fld	ST1				;		bbr	bbi	bbr
	fmul	ST0		, ST4		;		tibbr	bbi	bbr
	fld	ST1				;	bbi	tibbr	bbi	bbr
	fmul	ST0		, ST4		;	trbbi	tibbr	bbi	bbr
	faddp					;		bbbi	bbi	bbr
	fstp	tword [ecx + edx + 16]		;			bbi	bbr

	fmul	ST0		, ST3		;			tibbi	bbr
	fxch					;			bbr	tibbi
	fmul	ST0		, ST2		;			trbbr	tibbi
	fsubrp					;				bbbr
	fstp	tword [ecx + edx]		;

	cmp	ecx		, eax
	jne	.next

	fstp	ST0				; 		ti	ta	dta
	fstp	ST0				; 			ta	dta

	cmp	eax		, esi
	jne	.rewind

	fstp	ST0				; 				dta

	cmp	edx		, 32
	jne	.twiddle

	fstp	ST0				; 				

	pop	esi
	pop	edi
	pop	ebx

	ret
