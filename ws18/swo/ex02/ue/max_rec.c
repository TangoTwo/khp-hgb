#include <stdio.h>
#include <limits.h>

int max_rec(int a[], int from, int to) {
    if(to < from)
        return INT_MIN;
    else if(from == to)
        return a[from];
    else { // from < to 
        int mid = (from+to)/2;
        int max_left = max_rec(a, from, mid);
        int max_right = max_rec(a, mid+1, to);
        return max_left > max_right ? max_left : max_right;
    }
}
int max(int a[], int n) {
    return max_rec(a, 0, n-1);
}
    
int main() {
    int arr[] = { 3, 42, 8, 52, 7, 1, 3, 9};
    int arr_len = sizeof(arr)/sizeof(arr[0]);
    int m = max(arr, arr_len);
    printf("max(arr)=%d\n", m);
    
    return 0;
}
