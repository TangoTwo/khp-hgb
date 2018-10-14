#include <stdio.h>
#include <stdlib.h>
#define DIESEL 1
#define BENZIN 2

int main(int argc, char * argv[]){
	if(argc != 3) {
		printf("Invalid number of arguments!\n");
		return 2;
	}
	
	float avgConsumption = atof(argv[1]);
	int fuelType = atoi(argv[2]);
	float nova = 0;
	int subtractor;
	
	if(fuelType == DIESEL)
		subtractor = 2;
	else if(fuelType == BENZIN)
		subtractor = 3;
	else {
		printf("Invalid fuel type!\n");
		return 1;
	}
	nova = (avgConsumption - subtractor) * 200;
	printf("Nova=%.2f\n",nova);
	return 0;
}