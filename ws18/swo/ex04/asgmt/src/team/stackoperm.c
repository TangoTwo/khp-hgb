//
// Created by khp on 03.11.18.
//
#include <stdio.h>
#include <stdlib.h>
#include "stackoperm.h"
/* Function to swap values at two pointers */
void swap (int *x, int *y)
{   int temp;
    temp = *x;
    *x = *y;
    *y = temp;
}

/* calculate n factorial */
unsigned long long nfact (size_t n)
{   if (n <= 0) return 1;
    unsigned long long s = n;

    while (--n) s *= n;

    return s;
}

/* calculate possible permutations */
unsigned long long pnk (size_t n, size_t k)
{   size_t d = (k < n ) ? n - k : 1;
    return nfact (n) / nfact (d);
}

/* permute integer array for elements 'i' through 'n' */
void permute (int *a, size_t i, size_t n)
{   size_t j;
    if (i == n)
        prnarray (a, n);
    else
        for (j = i; j < n; j++) {
            swap ((a+i), (a+j));
            permute (a, i+1, n);
            swap ((a+i), (a+j));  // backtrack
        }
}

void prnarray (int *a, size_t sz)
{   size_t i;
    for (i = 0; i < sz; i++) printf (" %2d", a[i]);
    putchar ('\n');
}