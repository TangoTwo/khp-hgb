#include <stdio.h>
#include <stdlib.h>
#define DIESEL 1
#define BENZIN 2

int main(int argc, char * argv[]){
	int avgConsumption = atoi(argv[1]);
	int fuelType = atoi(argv[2]);
	int nova = 0;
	int subtractor;
	if(argc != 3) {
		printf("Invalid number of arguments!\n");
		return 2;
	}
	
	if(fuelType == DIESEL)
		subtractor = 2;
	else if(fuelType == BENZIN)
		subtractor = 3;
	else {
		printf("Invalid fuel type!\n");
		return 1;
	}
	nova = (avgConsumption - subtractor) * 200;
	printf("Nova=%d\n",nova);
	return 0;
}