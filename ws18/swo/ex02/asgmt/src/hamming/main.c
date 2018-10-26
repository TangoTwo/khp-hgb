#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define MAX 10000
#define HAMMING_NUMBERS {2, 3, 5}
#define HAMMING_NUMBERS_LENGTH 3

int inArray(int val, int a[], int length) {
    for(int i = 0; i < length; i++) {
        if(a[i] == val)
            return 1;
    }
    return 0;
}

void hamming_sequence(int maxZ, int hammingArr[], int *length) {
    int n = 1;
    int i = 1;
    int h = 0;
    
    hammingArr[0] = 1;
    while((i < maxZ) && (n < MAX)) {
        int multiplierArr[] = HAMMING_NUMBERS;
        for(int j = 0; j < HAMMING_NUMBERS_LENGTH; j++) {
            int temp = i * multiplierArr[j];
            if(temp <= maxZ && !inArray(temp, hammingArr, n)) {
                hammingArr[n] = temp;
                n++;
            }
        }
        h++;
        i = hammingArr[h];
    }
    *length = n;
}

void merge_sort(int a[], int length) {
    if(length <= 1)
        return;
    else {
        int left[length];
        int right[length];
        int leftMax = ceil((double)length/2);
        int rightMax = floor((double)length/2);
        
        for(int i = 0; i < leftMax; i++)
            left[i] = a[i];
        for(int i = 0; i < rightMax; i++)
            right[i] = a[leftMax + i];
        
        merge_sort(left, leftMax);
        merge_sort(right, rightMax);
        
        int leftIndex = 0;
        int rightIndex = 0;
        
        for(int i = 0; i < length; i++) {
            if(leftIndex >= leftMax) { //left array fully in a[]
                a[i] = right[rightIndex];
                rightIndex++;
            } else if(rightIndex >= rightMax) { //right array fully in a[]
                a[i] = left[leftIndex];
                leftIndex++;
            } else {
                if(left[leftIndex] < right[rightIndex]) {
                    a[i] = left[leftIndex];
                    leftIndex++;
                } else {
                    a[i] = right[rightIndex];
                    rightIndex++;
                }
            }
        }
    }
}

void printArray(int a[], int n) {
    for(int i = 0; i < n; i++) {
        printf("array[%d]=%d\n", i, a[i]);
    }
}

int main(int argc, char* argv[]) {
    clock_t start, end;
    double cpuTime;
    int maxZ;
    int hammingArr[MAX];
    int length;
    
    start = clock();
	if(argc != 2) {
		printf("Usage: %s Z\n", argv[0]);
		printf("Where Z is the maximum number.\n");
        return EXIT_FAILURE;
	}
	maxZ = atoi(argv[1]);
    if(maxZ <= 0) {
        printf("Please enter a number greater than 0!\n");
        return EXIT_FAILURE;
    }
    
    hamming_sequence(maxZ, hammingArr, &length);
    merge_sort(hammingArr, length);
    end = clock();
    printArray(hammingArr, length);
    cpuTime = ((double) (end-start)) / CLOCKS_PER_SEC;
    printf("Time taken in seconds: %f\n", cpuTime);
	return EXIT_SUCCESS;
}
