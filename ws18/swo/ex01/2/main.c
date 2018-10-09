#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define POINT_FORMAT "P%d[%d,%d]"

int main(int argc, char * argv[]){
	double polyPerimeter = 0;
	if(argc == 1) {
		printf("Usage: %s point1x point1y point2x point2y point3x point3y [pointNx pointNy]\n", argv[0]);
		return 1;
	} else if(argc < 7 || argc%2 == 0) {
		printf("Wrong number of arguments. At least 3 points have to be specified!\n");
		return 2;
	}
	int i;
	int firstX = atoi(argv[1]);
	int prevX = firstX;
	int firstY = atoi(argv[2]);
	int prevY = firstY;
	
	for(i = 3; i < argc-1; i+=2){ //start with 3 --> distance 2nd point to 1st point
		int px = atoi(argv[i]);
		int py = atoi(argv[i+1]);

		printf("P%d[%d,%d],", i/2, prevX, prevY);
		polyPerimeter += sqrt(((px-prevX)*(px-prevX)) + ((py-prevY)*(py-prevY)));
		prevX = px;
		prevY = py;
	}
	polyPerimeter += sqrt(((firstX-prevX)*(firstX-prevX))+ ((firstY-prevY)*(firstY-prevY)));
	printf("P%d[%d,%d]=%f\n", i/2, prevX, prevY, polyPerimeter);
	return 0;
}