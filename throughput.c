#include "ctfft.h"
#include "ctfftc.h"

#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define test(type, procedure, type_string)						\
	printf("%s\n", type_string);							\
	printf("%4s %10s %10s\n", "qty", "avg time", "avg rate");			\
	for(long long i = 4ll; i < 22ll; ++i)						\
	{										\
		long long elapsed_us = 0;						\
		long long n = 1ll << i;							\
		type * c = malloc(n * sizeof(type));					\
											\
		for(long long j = 0ll; j < (1ll << (21ll - i)); ++j)			\
		{									\
			for(long long k = 0ll; k < n; ++k)				\
			{								\
				c[k].r = (float)rand() / (float)RAND_MAX;		\
				c[k].i = (float)rand() / (float)RAND_MAX;		\
			}								\
											\
			clock_t start = clock();					\
			procedure(c, c + n);						\
			elapsed_us += clock() - start;					\
		}									\
											\
		long long throughput_MiBs = ((long long)sizeof(type) 			\
					   * (long long)CLOCKS_PER_SEC			\
					  << 1)						\
					  / elapsed_us;					\
		elapsed_us = (elapsed_us						\
			    * 1000000ll							\
			    / (long long)CLOCKS_PER_SEC)				\
			  >> (21ll - i);						\
		printf("2^%2lld %7lld us %4lld MiB/s\n"					\
		     , i								\
		     , elapsed_us							\
		     , throughput_MiBs);						\
											\
		free(c);								\
	}

int main()
{
	srand(clock());
	test(complexf, ctfftcf, "floats via C");
	printf("\n");
	test(complexf, ctfftf, "floats via asm");
	printf("\n\n");
	test(complexd, ctfftcd, "doubles via C");
	printf("\n");
	test(complexd, ctfftd, "doubles via asm");
	printf("\n\n");
	test(complexl, ctfftcl, "long doubles via C");
	printf("\n");
	test(complexl, ctfftl, "long doubles via asm");

	return 0;
}
