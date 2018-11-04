#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <limits.h>

#define MAX_VALUE 500
#define MAX_COINS 10

int n_iterations;

static int min(int a, int b){
	return a < b ? a : b;
}

static int min_coins_dc(int value, int coin_values[], int n_coins) {
	n_iterations++;
	assert(value >= 0);
	
	if(value == 0)
		return 0;

	int min_coins = INT_MAX;

	
	for(int k=n_coins-1; k >= 0; k--) {
		if(value >= coin_values[k]){
		
			int m = min_coins_dc(value - coin_values[k], coin_values, n_coins);
			min_coins = min(min_coins, m + 1);
		}
	}
	return min_coins;
}

static int min_coins_dp1(int value, int coin_values[], int n_coins){
	assert(value >= 0);

	int min_coins[MAX_VALUE+1];

	min_coins[0]=0;
	for(int v=1; v <= value; v++){
		min_coins[v] = INT_MAX;
		for (int k=n_coins-1; k >= 0; k--){
			if(v >= coin_values[k]) {
				min_coins[v] = min(min_coins[v], min_coins[v-coin_values[k]]+1);
				n_iterations++;
			}
		}
	}
	return min_coins[value];
}

static int min_coins_dp2(int value, int coin_values[], int coin_number[], int n_coins){
	assert(value >= 0);

	int min_coins[MAX_VALUE+1];
	int coin_index[MAX_VALUE+1];
	
	min_coins[0]=0;
	for(int v=1; v <= value; v++){
		min_coins[v] = INT_MAX;
		for (int k=n_coins-1; k >= 0; k--){
			if(v >= coin_values[k]) {
				if( min_coins[v-coin_values[k]]+1 < min_coins[v]) {
					min_coins[v] = min(min_coins[v], min_coins[v-coin_values[k]]+1);
					coin_index[v] = k;
				}

				
				n_iterations++;
			}
		}
	}
	
	for(int k = 0; k <= n_coins; k++) coin_number[k] = 0;
	int v = value;
	while(v > 0) {
		int k = coin_index[v];
		coin_number[k]++;
		v -= coin_values[k];
	}

	return min_coins[value];
}

int main() {
	int coins[] = { 1, 2, 5, 10, 20, 50};
	int coin_numbers[MAX_COINS];
	int n_coins = sizeof(coins)/sizeof(coins[0]);

	n_iterations = 0;
	int min_coins = min_coins_dc(34, coins, n_coins);
	printf("min_coins_dc(34)=%d, n_iterations=%d\n", min_coins, n_iterations);

	n_iterations = 0;
	min_coins = min_coins_dp1(34, coins, n_coins);
	printf("min_coins_dp1(34)=%d, n_iterations=%d\n", min_coins, n_iterations);
	
	n_iterations = 0;
	min_coins = min_coins_dp2(34, coins, coin_numbers,  n_coins);
	printf("min_coins_dp2(34)=%d, n_iterations=%d\n", min_coins, n_iterations);
	for(int j = 0; j<n_coins; j++){
		if(coin_numbers[j] > 0)
			printf("%d x %d\n", coin_numbers[j], coins[j]);
	}
	
	return 0;
}