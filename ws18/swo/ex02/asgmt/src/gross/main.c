#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <limits.h>

#define MAX 1000
#define ARG_ARRAY_START 2

void printUsage() {
    printf("Usage: sort ith_largest arr1 [aX]\n");
}

void printMaxWarning() {
    printf("Too many values. Array can't be bigger than %d values!\n", MAX);
}

int checkArguments(int argc, char * argv[]) {
    int success = 0;
    if(argc < ARG_ARRAY_START + 1) //too few values.
        printUsage();
    else if(argc-ARG_ARRAY_START > MAX) //too many values for array.
        printMaxWarning();
    else if(atoi(argv[1]) <= 0) { //ith element is smaller than 0. Can't search for that.
        printf("ith_largest must be bigger than 0!\n");
        printUsage;
    }
    else
        success = 1;
    return success;
}

int parseArray(int argc, char* argv[], int a[]) { //parses array. Returns array length or 0 if error occurs
    int arrayLength = 0;
    int i;
    for(i = ARG_ARRAY_START; i < argc; i++) {
        a[i-ARG_ARRAY_START] = atoi(argv[i]);
    }
    arrayLength = i-ARG_ARRAY_START;
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

int second_largest(int a[], int n) {
    int largest = INT_MIN;
    int secondLargest = INT_MIN;
    
    for(int i = 0; i < n; i++) {
        if(a[i] > largest) {
            secondLargest = largest;
            largest = a[i];
        }
        else if(a[i] > secondLargest)
            secondLargest = a[i];
    }
    return secondLargest;
}

int ith_largest_1(int a[], int n, int i) {
    merge_sort(a, n);
    return a[i];
}

int ith_largest_2(int a[], int n, int ithElement) {
    int pivot = a[n-1]; // take last element as pivot
    int smaller[n];
    int bigger[n];
    int smallerIndex = 0;
    int biggerIndex = 0;
    
    for(int i = 0; i < n-1; i++) {
        if(a[i] > pivot) {
            bigger[biggerIndex] = a[i];
            biggerIndex++;
        } else {
            smaller[smallerIndex] = a[i];
            smallerIndex++;
        }
    }
    
    if(biggerIndex == ithElement) { //element in bigger array
        return pivot;
    } else if(biggerIndex > ithElement) {
        return ith_largest_2(bigger, biggerIndex, ithElement);
    } else {
        return ith_largest_2(smaller, smallerIndex, ithElement - (1 + biggerIndex));
    }
}

int main(int argc, char * argv[]) {
    int n = 0;
    int a[MAX] = {0};
    
    if(!checkArguments(argc, argv))
        return EXIT_FAILURE;
    
    int searchedElement = atoi(argv[1]);
        
    
    n = parseArray(argc, argv, a);
    
    printf("### array ###\n");
    printArray(a, n);
    printf("\n\n");
    
    
    printf("2nd largest element=%d\n", second_largest(a, n));
    printf("%dth largest element=%d\n", searchedElement, ith_largest_1(a, n, searchedElement-1)); // -1 because arrays start at 0. 1st element = arr[0]
    printf("%dth largest element=%d\n", searchedElement, ith_largest_2(a, n, searchedElement-1)); // -1 because arrays start at 0. 1st element = arr[0]
    printArray(a, n);
    return 0;
}
