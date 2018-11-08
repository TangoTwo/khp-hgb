#include <stdio.h>

#ifndef MAX_LEN
#define MAX_LEN 100
#endif

#define MAX(a,b) ((a)>(b) ? (a) : (b))
#define MULT(a,b) ((a)*(b))

int main() {
	//int arr[MAX_LEN];

	int max = MAX(17, 10);
	printf("max=%d\n", max);

	int mult1 = MULT(3, 5);
	printf("mult1=%d\n", mult1);

	int mult2 = MULT(5+1, 7+3);
	printf("mult2=%d\n", mult2);

	int a = 5;
	int b = 1;

	int m1 = MAX(++a, b);
	int m2 = MAX(++a, b);
	printf("m1=%d, m2=%d, a=%d, b=%d\n", m1, m2, a, b);

	printf("MAX_LEN=%d\n", MAX_LEN);
	
	return 0;
}