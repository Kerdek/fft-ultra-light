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
	mov	ecx		, esi
	sub	ecx		, edi
	shr	ecx		, 1
	mov	edx		, edi
	sub	esi		, ecx

	shr	ecx		, 3
	push	ecx
	shl	ecx		, 3

	fldpi
	fchs
	fild 	dword [esp]
	fdivp	ST1		, ST0
	fldz
	fldz
	fld1

	add	esp		, 4

.begin:

	fld	dword [edx + 4]
	fld	ST0
	fld	dword [edx + ecx + 4]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	dword [edx + 4]
	fld	dword [edx + 0]
	fld	ST0
	fld	dword [edx + ecx + 0]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	dword [edx + 0]
	fld	ST0
	fmul	ST0		, ST3
	fld	ST2
	fmul	ST0		, ST5
	fsubp	ST1		, ST0
	fstp	dword [edx + ecx + 0]
	fmul	ST0		, ST3
	fld	ST1
	fmul	ST0		, ST3
	faddp	ST1		, ST0
	fstp	dword [edx + ecx + 4]
	fstp	ST0

	cmp	edx		, eax
	je	.rewind

	lea	edx		, [edx + ecx * 2]

	jmp	.begin

.rewind:

	add	eax		, 8

	cmp	eax		, esi
	je	.twiddle

	add	ebx		, 8
	mov	edx		, ebx

	fstp	ST0
	fstp	ST0
	fadd	ST0		, ST1
	fld	ST0
	fsin
	fld	ST1
	fcos

	jmp	.begin

.twiddle:

	cmp	ecx		, 8
	je	.end
	
	mov	ebx		, edi
	mov	edx		, ebx
	shr	ecx		, 1
	add	esi		, ecx

	fstp	ST0
	fstp	ST0
	fstp	ST0
	fld1
	fld1
	faddp	ST1		, ST0
	fmulp	ST1		, ST0
	fldz
	fldz
	fld1

	jmp	.begin

.end:

	fstp	ST0
	fstp	ST0
	fstp	ST0
	fstp	ST0

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
	mov	ecx		, esi
	sub	ecx		, edi
	shr	ecx		, 1
	mov	edx		, edi
	sub	esi		, ecx

	shr	ecx		, 4
	push	ecx
	shl	ecx		, 4

	fldpi
	fchs
	fild 	dword [esp]
	fdivp	ST1		, ST0
	fldz
	fldz
	fld1

	add	esp		, 4

.begin:

	fld	qword [edx + 8]
	fld	ST0
	fld	qword [edx + ecx + 8]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	qword [edx + 8]
	fld	qword [edx]
	fld	ST0
	fld	qword [edx + ecx]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	qword [edx]
	fld	ST0
	fmul	ST0		, ST3
	fld	ST2
	fmul	ST0		, ST5
	fsubp	ST1		, ST0
	fstp	qword [edx + ecx]
	fmul	ST0		, ST3
	fld	ST1
	fmul	ST0		, ST3
	faddp	ST1		, ST0
	fstp	qword [edx + ecx + 8]
	fstp	ST0

	cmp	edx		, eax
	je	.rewind

	lea	edx		, [edx + ecx * 2]

	jmp	.begin

.rewind:

	add	eax		, 16

	cmp	eax		, esi
	je	.twiddle

	add	ebx		, 16
	mov	edx		, ebx

	fstp	ST0
	fstp	ST0
	fadd	ST0		, ST1
	fld	ST0
	fsin
	fld	ST1
	fcos

	jmp	.begin

.twiddle:

	cmp	ecx		, 16
	je	.end
	
	mov	ebx		, edi
	mov	edx		, ebx
	shr	ecx		, 1
	add	esi		, ecx

	fstp	ST0
	fstp	ST0
	fstp	ST0
	fld1
	fld1
	faddp	ST1		, ST0
	fmulp	ST1		, ST0
	fldz
	fldz
	fld1

	jmp	.begin

.end:

	fstp	ST0
	fstp	ST0
	fstp	ST0
	fstp	ST0

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
	mov	ecx		, esi
	sub	ecx		, edi
	shr	ecx		, 1
	mov	edx		, edi
	sub	esi		, ecx

	shr	ecx		, 5
	push	ecx
	shl	ecx		, 5

	fldpi
	fchs
	fild 	dword [esp]
	fdivp	ST1		, ST0
	fldz
	fldz
	fld1

	add	esp		, 4

.begin:

	fld	tword [edx + 16]
	fld	ST0
	fld	tword [edx + ecx + 16]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	tword [edx + 16]
	fld	tword [edx]
	fld	ST0
	fld	tword [edx + ecx]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	tword [edx]
	fld	ST0
	fmul	ST0		, ST3
	fld	ST2
	fmul	ST0		, ST5
	fsubp	ST1		, ST0
	fstp	tword [edx + ecx]
	fmul	ST0		, ST3
	fld	ST1
	fmul	ST0		, ST3
	faddp	ST1		, ST0
	fstp	tword [edx + ecx + 16]
	fstp	ST0

	cmp	edx		, eax
	je	.rewind

	lea	edx		, [edx + ecx * 2]

	jmp	.begin

.rewind:

	add	eax		, 32

	cmp	eax		, esi
	je	.twiddle

	add	ebx		, 32
	mov	edx		, ebx

	fstp	ST0
	fstp	ST0
	fadd	ST0		, ST1
	fld	ST0
	fsin
	fld	ST1
	fcos

	jmp	.begin

.twiddle:

	cmp	ecx		, 32
	je	.end
	
	mov	ebx		, edi
	mov	edx		, ebx
	shr	ecx		, 1
	add	esi		, ecx

	fstp	ST0
	fstp	ST0
	fstp	ST0
	fld1
	fld1
	faddp	ST1		, ST0
	fmulp	ST1		, ST0
	fldz
	fldz
	fld1

	jmp	.begin

.end:

	fstp	ST0
	fstp	ST0
	fstp	ST0
	fstp	ST0

	pop	esi
	pop	edi
	pop	ebx
	ret
