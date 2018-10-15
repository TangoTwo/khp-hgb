#include <stdio.h>
#include <string.h>

#define MAX_LEN 5
#define N_ROWS 4
#define N_COLS 3

void pointer_test() {
    int i = 42;
    int *pi = &i;
    
    printf("i=%d\n", i);
    printf("pi=%p\n", (void*)pi);
    printf("i=%d\n", *pi);
}

void array_test() {
    int arr[MAX_LEN];
    
    for(int i=0; i<MAX_LEN; i++) {
        printf("arr+%d=%p, *(arr+%d)=%d\n", i, (void*)(arr+i), i, *(arr+i));
    }
    
    for(int i=0; i<MAX_LEN;i++) {
        arr[i] = 10*i;
    }
    
    for(int i=0; i<MAX_LEN; i++) {
        printf("arr+%d=%p, *(arr+%d)=%d\n", i, (void*)(arr+i), i, *(arr+i));
    }
}

void string_test() {
    //char str[6] = {'H','A','L','L','O','\0'};
    //char str[] = {'H','A','L','L','O','\0'};
    //char str[] = "HALLO";
    //printf("str = %s\n", str);
    
    char str1[]= "hello ";
    char str2[] = "world";
    char result[20];
    
    printf("str1.length=%d, str2.length=%d\n", (int)strlen(str1), (int)strlen(str2));
    
    strcpy(result, str1);
    strcat(result, str2);
    
    printf("result = %s\n", result);
}

void multi_dim_test() {
    int mat[N_ROWS][N_COLS] = {
        { 1, 2, 3}, 
        { 4, 5, 6}, 
        { 7, 8, 9}, 
        { 10, 11, 12}
    };
    for(int i=0;i<N_ROWS;i++) {
        for(int j=0;j<N_COLS;j++) {
            printf("mat[%d][%d]=%d\n", i, j, mat[i][j]);
        }
    }
}

int main() {
    printf("==== pointer_test() =====\n");
    pointer_test();
    printf("==== array_test() =====\n");
    array_test();
    printf("==== string_test() =====\n");
    string_test();
    printf("==== multi_dim_test() =====\n");
    multi_dim_test();
    
    return 0;
}
