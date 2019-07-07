#include "complexes.h"

/*
Description of `ctfftf`, `ctfftd`, and `ctfftl`.

If the preconditions are met, the behavior is to compute the fast Fourier
transform of a sequence of complex numbers in-place. If the preconditions
are not met, the behavior is undefined.

The computation is done according to the Cooley-Tukey algorithm for radix two.
The result is in bit-reversed order. A separate procedure is required to put
the elements in conventional order.

Preconditions:
	- `end - begin` is a power of two.
	- `end - begin` is greater than one.
	- `begin` points to an array of `end - begin` complexes
	- On 32-bit systems, there are at least 24 bytes of remaining stack.
	- On 64-bit systems, there are at least 16 bytes of remaining stack.
	  (The stack is used only for arguments and register saving).
Postconditions:
	- The array at `begin` is replaced by the discrete Fourier transform
	  of the original array, in bit-reversed order.
*/

void ctfftf(complexf * begin, complexf * end);
void ctfftd(complexd * begin, complexd * end);
void ctfftl(complexl * begin, complexl * end);
