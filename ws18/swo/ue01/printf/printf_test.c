#include <stdio.h>

int main(){
	short s = 123;
	int i = 1234567;
	double d = 3.1415927;
	char * str = "abcdefg";

	printf("<%d>\n", i);
	printf("<%hd>\n", s);
	printf("<%10d>\n", i);
	printf("<%-10d>\n", i);
	printf("<%010d>\n", i);

	printf("<%10s>\n", str);
	printf("<%-10s>\n", str);

	printf("<%f>\n", d);
	printf("<%.3f>\n", d);
	printf("<%10.3f>\n", d);
	
	printf("<%#x>\n", s);
	printf("<%#o>\n", s);
	
	return 0;
}