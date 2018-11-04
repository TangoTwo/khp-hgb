#include <stdio.h>

#define MAX 100

int longest_increasing_run(int const s[], int const n){
    int longestRun = 0;
    int currentRun = 1;
    for (int i = 1; i < n; ++i) {
        if(s[i] > s[i-1]){
            currentRun++;
        } else {
            if(currentRun > longestRun) {
                longestRun = currentRun;
            }
            currentRun = 1;
        }
    }
    return longestRun;
}

int longest_increasing_subsequence(int const s[], int const n){
    int l[MAX];
    int p[MAX];
    int maxL = -1;
    int maxLIndex = -1;
    for (int i = 0; i < n; ++i) {
        int tempL = 0;
        int tempP = 0;
        for (int j = 1; j < i; ++j) {
            if(s[i] > s[j]){
                if(l[j] > tempL){
                    tempL = l[j];
                    tempP = j;
                }
            }
        }
        l[i] = tempL+1;
        p[i] = tempP;
        if(l[i] >= maxL) {
            maxL = l[i];
            maxLIndex = i;
        }
    }
    int nextIndex = maxLIndex;
    for (int m = 0; m < l[maxLIndex]; ++m) {
        printf("%i - ", s[nextIndex]);
        nextIndex = p[nextIndex];
    }
    printf("\n");
    return maxL;
}

int main() {
    int const s[MAX] = {9, 5, 2, 8, 7, 3, 1, 6, 4};
    int const n = 9;

    printf("%i", longest_increasing_run(s, n));
    printf("%i", longest_increasing_subsequence(s, n));
    return 0;
}