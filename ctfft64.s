section .text
global ctfftf

ctfftf:
	mov	rax		, rdi
	mov	rbx		, rdi
	mov	rcx		, rsi
	sub	rcx		, rdi
	shr	rcx		, 1
	mov	rdx		, rdi
	sub	rsi		, rcx

	shr	rcx		, 3
	push	rcx
	shl	rcx		, 3

	fldpi
	fchs
	fild 	qword [rsp]
	fdivp	ST1		, ST0
	fldz
	fldz
	fld1

	add	rsp		, 8

.begin:

	fld	dword [rdx + 4]
	fld	ST0
	fld	dword [rdx + rcx + 4]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	dword [rdx + 4]
	fld	dword [rdx + 0]
	fld	ST0
	fld	dword [rdx + rcx + 0]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	dword [rdx + 0]
	fld	ST0
	fmul	ST0		, ST3
	fld	ST2
	fmul	ST0		, ST5
	fsubp	ST1		, ST0
	fstp	dword [rdx + rcx + 0]
	fmul	ST0		, ST3
	fld	ST1
	fmul	ST0		, ST3
	faddp	ST1		, ST0
	fstp	dword [rdx + rcx + 4]
	fstp	ST0

	cmp	rdx		, rbx
	je	.rewind

	lea	rdx		, [rdx + rcx * 2]

	jmp	.begin

.rewind:

	add	rbx		, 8

	cmp	rbx		, rsi
	je	.twiddle

	add	rax		, 8
	mov	rdx		, rax

	fstp	ST0
	fstp	ST0
	fadd	ST0		, ST1
	fld	ST0
	fsin
	fld	ST1
	fcos

	jmp	.begin

.twiddle:

	cmp	rcx		, 8
	je	.end
	
	mov	rax		, rdi
	mov	rdx		, rax
	shr	rcx		, 1
	add	rsi		, rcx

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

	ret

global ctfftd

ctfftd:
	mov	rax		, rdi
	mov	rbx		, rdi
	mov	rcx		, rsi
	sub	rcx		, rdi
	shr	rcx		, 1
	mov	rdx		, rdi
	sub	rsi		, rcx

	shr	rcx		, 4
	push	rcx
	shl	rcx		, 4

	fldpi
	fchs
	fild 	qword [rsp]
	fdivp	ST1		, ST0
	fldz
	fldz
	fld1

	add	rsp		, 8

.begin:

	fld	qword [rdx + 8]
	fld	ST0
	fld	qword [rdx + rcx + 8]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	qword [rdx + 8]
	fld	qword [rdx]
	fld	ST0
	fld	qword [rdx + rcx]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	qword [rdx]
	fld	ST0
	fmul	ST0		, ST3
	fld	ST2
	fmul	ST0		, ST5
	fsubp	ST1		, ST0
	fstp	qword [rdx + rcx]
	fmul	ST0		, ST3
	fld	ST1
	fmul	ST0		, ST3
	faddp	ST1		, ST0
	fstp	qword [rdx + rcx + 8]
	fstp	ST0

	cmp	rdx		, rbx
	je	.rewind

	lea	rdx		, [rdx + rcx * 2]

	jmp	.begin

.rewind:

	add	rbx		, 16

	cmp	rbx		, rsi
	je	.twiddle

	add	rax		, 16
	mov	rdx		, rax

	fstp	ST0
	fstp	ST0
	fadd	ST0		, ST1
	fld	ST0
	fsin
	fld	ST1
	fcos

	jmp	.begin

.twiddle:

	cmp	rcx		, 16
	je	.end
	
	mov	rax		, rdi
	mov	rdx		, rax
	shr	rcx		, 1
	add	rsi		, rcx

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

	ret

global ctfftl

ctfftl:

	mov	rax		, rdi
	mov	rbx		, rdi
	mov	rcx		, rsi
	sub	rcx		, rdi
	shr	rcx		, 1
	mov	rdx		, rdi
	sub	rsi		, rcx

	shr	rcx		, 5
	push	rcx
	shl	rcx		, 5

	fldpi
	fchs
	fild 	qword [rsp]
	fdivp	ST1		, ST0
	fldz
	fldz
	fld1

	add	rsp		, 8

.begin:

	fld	tword [rdx + 16]
	fld	ST0
	fld	tword [rdx + rcx + 16]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	tword [rdx + 16]
	fld	tword [rdx]
	fld	ST0
	fld	tword [rdx + rcx]
	fadd	ST1		, ST0
	fsubp	ST2		, ST0
	fstp	tword [rdx]
	fld	ST0
	fmul	ST0		, ST3
	fld	ST2
	fmul	ST0		, ST5
	fsubp	ST1		, ST0
	fstp	tword [rdx + rcx]
	fmul	ST0		, ST3
	fld	ST1
	fmul	ST0		, ST3
	faddp	ST1		, ST0
	fstp	tword [rdx + rcx + 16]
	fstp	ST0

	cmp	rdx		, rbx
	je	.rewind

	lea	rdx		, [rdx + rcx * 2]

	jmp	.begin

.rewind:

	add	rbx		, 32

	cmp	rbx		, rsi
	je	.twiddle

	add	rax		, 32
	mov	rdx		, rax

	fstp	ST0
	fstp	ST0
	fadd	ST0		, ST1
	fld	ST0
	fsin
	fld	ST1
	fcos

	jmp	.begin

.twiddle:

	cmp	rcx		, 32
	je	.end
	
	mov	rax		, rdi
	mov	rdx		, rax
	shr	rcx		, 1
	add	rsi		, rcx

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

	ret
