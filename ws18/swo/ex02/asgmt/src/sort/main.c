#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define MAX 1000

void printUsage() {
    printf("Usage: sort a1 [aX]\n");
}

void printMaxWarning() {
    printf("Too many values. Array can't be bigger than %d values!\n", MAX);
}

int checkArguments(int argc) {
    int success = 0;
    if(argc < 2)
        printUsage();
    else if(argc-1 > MAX)
        printMaxWarning();
    else
        success = 1;
    return success;
}

int parseArray(int argc, char* argv[], int a[]) { //parses array. Returns array length or 0 if error occurs
    int arrayLength = 0;
    int i;
    for(i = 1; i < argc; i++) {
        a[i-1] = atoi(argv[i]);
    }
    arrayLength = i-1;
    return arrayLength;
}

void printArray(int a[], int n) {
    for(int i = 0; i < n; i++) {
        printf("array[%d]=%d\n", i, a[i]);
    }
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
                if(left[leftIndex] > right[rightIndex]) {
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

int main(int argc, char * argv[]) {
    int n = 0;
    int a[MAX] = {0};
    
    if(!checkArguments(argc))
        return EXIT_FAILURE;
    
    n = parseArray(argc, argv, a);
    
    printf("### Unsorted array ###\n");
    printArray(a, n);
    printf("\n\n");
    
    merge_sort(a, n);
    
    printf("### Sorted array ###\n");
    printArray(a, n);
    printf("\n\n");
    
    return EXIT_SUCCESS;
}
