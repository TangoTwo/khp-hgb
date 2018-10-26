#include <stdio.h>

#define MAX_N 100
#define bool  int
#define false 0
#define true  1

static bool queen_fits(const int col[], int i, int j);
static void print_solution(const int col[], int n);
static int solution_nr = 0;

static void place_queen(int col[], int i, int n) {
	for(int j = 1; j<=n; j++) {
		if(queen_fits(col, i, j)){
			col[i] = j;
			if(i==n){
				solution_nr++;
				print_solution(col, n);
			}
			else
				place_queen(col, i+1, n);
			col[i] = 0;
		}
	}
} /*place_queen*/


static bool queen_fits(const int col[], int i, int j) {
	int k;
	for (k = 1; k < i; k++) {
		if (( col[k] == j ) ||
			  (k+col[k] == i+j) ||
			  (k-col[k] == i-j))
			return false;
	} /*for*/
	return true;
} /* queen_fits */

static void print_solution(const int col[], int n) {
	printf("solution %d\n", solution_nr);
	for(int i = 1; i <= n; i++){
		for(int j = 0; j <=n; j++) {
			if(col[i] == j)
				printf("D ");
			else
				printf("- ");
		}
		printf("\n");
	}
	printf("\n");
} /* print_solution */

int main() {
	int col[MAX_N+1];
	
	solution_nr = 0;
	place_queen(col, 1, 12);
	return 0;
}
