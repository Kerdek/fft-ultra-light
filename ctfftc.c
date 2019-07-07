#include "ctfftc.h"

#include <math.h>
#include <stddef.h>

void ctfftcf(complexf * edi, complexf * esi)
{
	ptrdiff_t ecx;
	complexf * eax, * ebx, * edx;
	float tr, ti, dta, ta;

	edi = edi;
	esi = esi;
	ecx = esi - edi;
	edx = edi;
	ebx = edi;
	eax = esi - ecx;
	ecx >>= 1;
	esi -= ecx;

	dta = -M_PI / ecx;
	ta = 0.0f;
	tr = 1.0f;
	ti = 0.0f;

	for(;;)
	{
		float br, bi;

		br = edx[0].r - edx[ecx].r;
		bi = edx[0].i - edx[ecx].i;
		edx[0].r = edx[0].r + edx[ecx].r;
		edx[0].i = edx[0].i + edx[ecx].i;
		edx[ecx].r = br * tr - bi * ti;
		edx[ecx].i = br * ti + bi * tr;

		if(edx != eax) edx += 2 * ecx;
		else
		{
			if(++eax != esi)
			{
				++ebx;
				edx = ebx;

				ta += dta;
				tr = cos(ta);
				ti = sin(ta);
			}
			else
			{
				if(ecx == 1) return;
				ebx = edi;
				edx = ebx;
				ecx >>= 1;
				esi += ecx;

				dta *= 2.0f;
				ta = 0.0f;
				tr = 1.0f;
				ti = 0.0f;
			}
		}
	}
}


void ctfftcd(complexd * edi, complexd * esi)
{
	ptrdiff_t ecx;
	complexd * eax, * ebx, * edx;
	double tr, ti, dta, ta;

	edi = edi;
	esi = esi;
	ecx = esi - edi;
	edx = edi;
	ebx = edi;
	eax = esi - ecx;
	ecx >>= 1;
	esi -= ecx;

	dta = -M_PI / ecx;
	ta = 0.0f;
	tr = 1.0f;
	ti = 0.0f;

	for(;;)
	{
		double br, bi;

		br = edx[0].r - edx[ecx].r;
		bi = edx[0].i - edx[ecx].i;
		edx[0].r = edx[0].r + edx[ecx].r;
		edx[0].i = edx[0].i + edx[ecx].i;
		edx[ecx].r = br * tr - bi * ti;
		edx[ecx].i = br * ti + bi * tr;

		if(edx != eax) edx += 2 * ecx;
		else
		{
			if(++eax != esi)
			{
				++ebx;
				edx = ebx;

				ta += dta;
				tr = cos(ta);
				ti = sin(ta);
			}
			else
			{
				if(ecx == 1) return;
				ebx = edi;
				edx = ebx;
				ecx >>= 1;
				esi += ecx;

				dta *= 2.0f;
				ta = 0.0f;
				tr = 1.0f;
				ti = 0.0f;
			}
		}
	}
}

void ctfftcl(complexl * edi, complexl * esi)
{
	ptrdiff_t ecx;
	complexl * eax, * ebx, * edx;
	long double tr, ti, dta, ta;

	edi = edi;
	esi = esi;
	ecx = esi - edi;
	edx = edi;
	ebx = edi;
	eax = esi - ecx;
	ecx >>= 1;
	esi -= ecx;

	dta = -M_PI / ecx;
	ta = 0.0f;
	tr = 1.0f;
	ti = 0.0f;

	for(;;)
	{
		long double br, bi;

		br = edx[0].r - edx[ecx].r;
		bi = edx[0].i - edx[ecx].i;
		edx[0].r = edx[0].r + edx[ecx].r;
		edx[0].i = edx[0].i + edx[ecx].i;
		edx[ecx].r = br * tr - bi * ti;
		edx[ecx].i = br * ti + bi * tr;

		if(edx != eax) edx += 2 * ecx;
		else
		{
			if(++eax != esi)
			{
				++ebx;
				edx = ebx;

				ta += dta;
				tr = cos(ta);
				ti = sin(ta);
			}
			else
			{
				if(ecx == 1) return;
				ebx = edi;
				edx = ebx;
				ecx >>= 1;
				esi += ecx;

				dta *= 2.0f;
				ta = 0.0f;
				tr = 1.0f;
				ti = 0.0f;
			}
		}
	}
}
