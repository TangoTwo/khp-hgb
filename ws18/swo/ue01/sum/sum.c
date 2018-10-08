#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * argv[]){
	int i;
	int sum = 0;
	for(i=1; i<argc; i++){
		int value = atoi(argv[i]);
		printf("%d", value);
		if(i<argc-1){
			printf("+");
		}
		sum += value;
	}
	printf("=%d\n", sum);
	return 0;
}