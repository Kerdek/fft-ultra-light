# FFT Ultra-Light

RELEASED TO PUBLIC DOMAIN

## Summary

This is an implementation of the radix-2 Cooley Tukey fast Fourier transform that I have been fiddling with. I realized some time ago that there were enough registers available in x86 to completely avoid using auxiliary memory anywhere in the loop. The average C compiler is not smart enough to realize this. As such, there are two editions of the source and header files: one edition is written in C, and other is in x86 assembly. The assembly edition is also available for x64, but it does not perform as well as gcc's output for the C edition.

## Building

If compiling the assembly edition, use NASM to create a shared object from the desired version of the assembly portion of the source. Compile and link the C portion of the source using any C compiler. Link using any desired linker.

### For example, on Ubuntu 18.04:

- To create a 64-bit static library which exports the assembly edition, use `nasm -f elf64 ctfft64.s` to output the shared object `ctfft64.o`, then use `ar rcs libctfft64.a ctfft64.o` to output the static library `libctfft64.a`.

- To create a 32-bit executable which imports the the C edition, use `gcc -m32 -o <my_executable> <my_sources> ctfftc.c -lm` to output the executable `<my_executable>`.

## Usage

If linking the assembly edition, include the header `ctfft.h`, and call `ctfftf`, `ctfftd`, or `ctfftl`. If linking the C edition, include the header `ctfftc.h`, and call `ctfftcf`, `ctfftcd`, or `ctfftcl`.  Contracts for each function are described in each header file. It is possible to include both.

## Todo

- Outsmart GCC on x64
- Allow for different sizes of `float` `double` and `long double`.
- Write a decimation-in-time version.
- Further micro-optimize.
