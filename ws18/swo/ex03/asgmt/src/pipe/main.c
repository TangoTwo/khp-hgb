#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

void copyTo(int const a[], int b[], int const n){
	for(int i = 0; i < n; i++){
		b[i] = a[i];
	}
}

bool possibleIterative(int const x, int const lengths[], int const counts[], int const n) {
	for(int a = 0; a <= counts[0]; a++){
        for(int b = 0; b <= counts[1]; b++){
            for(int c = 0; c <= counts[2]; c++){
                for(int d = 0; d <= counts[3]; d++){
                    for(int e = 0; e <= counts[4]; e++){
                        for(int f = 0; f <= counts[5]; f++){
                            if(a*lengths[0] + b*lengths[1] + c*lengths[2] + d*lengths[3] + e*lengths[4] + f*lengths[5] == x)
                                return true;
                        }
                    }
                }
            }
        }
	}
	return false;
}

bool possibleRecursive(int const x, int const lengths[], int const counts[], int const n) {
	int i;
	int tempCounts[n];
	int tempX;
	for(i = 0; counts[i] <= 0 && i < n; i++); //get first stocked pipe length
	if(i == n) // no pipes left
        return false;
	else if(lengths[i] == x) //if current pipe is fitted length is reached
        return true;

	copyTo(counts, tempCounts, n);
	tempCounts[i] = 0; //reduce count (take pipe from stock)
	for(int count = 0; count <= counts[i]; count++){
        tempX = x - lengths[i]*count;
        if(possibleRecursive(tempX, lengths, tempCounts, n))
            return true;
	}
    return false;
}
bool possibleRecursiveWithBT(int const x, int const lengths[], int const counts[], int const n) {
    int i;
    int tempCounts[n];
    int tempX;
    for(i = 0; counts[i] <= 0 && i < n; i++); //get first stocked pipe length
    if(i == n) // no pipes left
        return false;

    copyTo(counts, tempCounts, n);
    tempCounts[i] = 0; //reduce count (take pipe from stock)
    for(int count = 0; count <= counts[i]; count++){
        tempX = x - lengths[i]*count;
        printf("%i ", tempX);
        if(tempX < 0)   //backtracking --> we are already above x in length
            return false;
        else if(tempX == 0)
        	return true;
        if(possibleRecursive(tempX, lengths, tempCounts, n))
            return true;
    }
    return false;
}

int main() {
    clock_t start_t, endIt_t, endRec_t, endRecBT_t;
    bool posIt, posRec, posRecBT;
	int const x = 330;
	int const lengths[] = {1, 3, 6, 10, 25, 1000};
	int const counts[] = {8, 5, 12, 15, 20, 0};
	int const n = 6;

	start_t = clock();
    posIt = possibleIterative(x, lengths, counts, n);
	endIt_t = clock();
    posRec = possibleRecursive(x, lengths, counts, n);
    endRec_t = clock();
    posRecBT = possibleRecursiveWithBT(x, lengths, counts, n);
    endRecBT_t = clock();
    printf("Total time iterative is %f with result: %i\n", ((double)(endIt_t - start_t)/CLOCKS_PER_SEC), posIt);
    printf("Total time recursive is %f with result: %i\n", ((double)(endRec_t - endIt_t)/CLOCKS_PER_SEC), posRec);
    printf("Total time recursive with backtracking is %f with result: %i\n", ((double)(endRecBT_t - endRec_t)/CLOCKS_PER_SEC), posRecBT);
	return 0;
}