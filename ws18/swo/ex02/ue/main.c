#include <stdio.h>
#define MAX_LEN 5

//const int MAX_LEN = 15;

void const_tests() {
	int arr[MAX_LEN];

	for(int i=0; i<MAX_LEN; i++) {
		arr[i] = i;
	}
	for(int i=0; i<MAX_LEN; i++) {
		printf("arr[%d]=%d\n", i, arr[i]);
	}
}

void char_test() {
	for(int i = 0; i<26; i++) {
		printf("%c ", 'a'+i);
	}
	printf("\n");
    for(int i = 0; i<26; i++) {
		printf("%d ", 'a'+i);
	}
	printf("\n");
}

void cast_test() {
    int i = 1;
    double d = (double)i/3;
    double d3 = d*3;
    
    printf("d=%.4f, d3=%.4f\n", d, d3);
}

void sizeof_types() {
    printf("sizeof(char)=%d\n", (int)sizeof(char));
    printf("sizeof(short)=%d\n", (int)sizeof(short));
    printf("sizeof(int)=%d\n", (int)sizeof(int));
    printf("sizeof(long)=%d\n", (int)sizeof(long));
    printf("sizeof(long long)=%d\n", (int)sizeof(long long));
    
    printf("sizeof(float)=%d\n", (int)sizeof(float));
    printf("sizeof(double)=%d\n", (int)sizeof(double));
    printf("sizeof(long double)=%d\n", (int)sizeof(long double));
}

int main() {
	printf("----CONST TESTS----\n");
	const_tests();
	printf("----CHAR TESTS----\n");
	char_test();
    cast_test();
    printf("----SIZE TESTS----\n");
	sizeof_types();
	return 0;
}
