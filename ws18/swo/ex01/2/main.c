#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * argv[]){

	if(argc == 1) {
		printf("Usage: %s point1x point1y point2x point2y point3x point3y [pointNx pointNy]\n", argv[0]);
	} else if(argc < 7 || argc%2 == 0) {
		printf("Wrong number of arguments. At least 3 points have to be specified!\n");
	}
	return 0;
}