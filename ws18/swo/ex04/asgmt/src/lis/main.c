#include <stdio.h>

#define MAX 100

int longest_increasing_run(int const s[], int const n){
    int longestRun = 0;
    int currentRun = 1;
    for (int i = 1; i < n; ++i) {
        if(s[i] > s[i-1]){
            currentRun++;
        } else {
            if(currentRun > longestRun)
                longestRun = currentRun;
            currentRun = 1;
        }
    }
    if(currentRun > longestRun)
    	longestRun = currentRun;
    return longestRun;
}

void printArray(int const s[], int const n, char const name[]) {
    for (int i = 0; i < n; ++i) {
        printf("%s[%i] = %i \n", name, i, s[i]);
    }
    printf("\n\n");
}

void printSequence(int const s[], int const l[], int const p[], int const maxLIndex) {
    int tSequence[MAX];
    int nextIndex = maxLIndex;
    for (int m = 0; m < l[maxLIndex]; ++m) {
        tSequence[m] = s[nextIndex];
        nextIndex = p[nextIndex];
    }

    for (int m = l[maxLIndex]-1; m >= 0; --m) {
        if(m == l[maxLIndex]-1)
            printf("%i ", tSequence[m]);
        else
            printf("- %i ", tSequence[m]);
    }
}

int longest_increasing_subsequence(int const s[], int const n){
    int l[MAX];
    int p[MAX];
    int maxLIndex = 0;
    for (int i = 0; i < n; ++i) {
        int tempL = 1;
        int tempP = -1;
        for (int j = 0; j < i; ++j) {
            if(s[i] > s[j]){
                if(l[j] >= tempL){
                    tempL = l[j]+1;
                    tempP = j;
                }
            }
        }
        l[i] = tempL;
        p[i] = tempP;
        if(l[i] >= l[maxLIndex]) {
            maxLIndex = i;
        }
    }
    printArray(s, n, "s");
    printArray(l, n, "l");
    printArray(p, n, "p");
    printSequence(s, l, p, maxLIndex);
    printf("\n");
    return l[maxLIndex];
}

int main() {
    //int const s[MAX] = {1,2,3,4,5,6,7,8,9};
    //int const s[MAX] = {9,8,7,6,5,4,3,2,1};
    int const s[MAX] = {0,0,0,0,0,0,0,0,0};
    int const n = 9;

    printf("Longest increasing run = %i \n\n\n", longest_increasing_run(s, n));
    printf("Longest increasing sequence = %i \n\n\n", longest_increasing_subsequence(s, n));
    return 0;
}