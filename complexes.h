#ifndef COMPLEXES_H
#define COMPLEXES_H

typedef struct
{
	float __attribute__ ((aligned (4))) r, i;
} complexf;

typedef struct
{
	double __attribute__ ((aligned (8))) r, i;
} complexd;

typedef struct
{
	long double __attribute__ ((aligned (16))) r, i;
} complexl;

#endif
