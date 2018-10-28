#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>

#define ARG_COUNT 2
#define SIDE_LENGTH 9
#define BLOCK_LENGTH 3
#define MAX_NUM 9

bool sudoku_solve2(int squares[SIDE_LENGTH][SIDE_LENGTH]);
int squaresPossible[SIDE_LENGTH][SIDE_LENGTH][MAX_NUM];

void printSudoku(int squares[SIDE_LENGTH][SIDE_LENGTH]){ //prints 2d sudokus
	for(int i = 0; i < SIDE_LENGTH; i++){
		for(int j = 0; j < SIDE_LENGTH; j++){
			printf("|%i", squares[i][j]);
		}
		printf("|\n");
	}
}

void convertSudoku(int squares[], int squares2d[SIDE_LENGTH][SIDE_LENGTH]){ //converts sudoku from 1-dim to 2-dim.
	int n = 0;
	for(int i = 0; i < SIDE_LENGTH; i++){
		for(int j = 0; j < SIDE_LENGTH; j++){
			squares2d[i][j] = squares[n];
			n++;
		}
	}
}

void inputNumbersIntoSudoku(int *squares, char *input){
	for(int i = 0; i < SIDE_LENGTH*SIDE_LENGTH; i++){
		squares[i] = (input[i])-48;
	}
}

void initSquaresPossible(){ //initialises the squaresPossibleArray, so sets every number in every square possible.
	for(int i = 0; i < SIDE_LENGTH; i++){
		for(int j = 0; j < SIDE_LENGTH; j++){
			for(int k = 0; k < MAX_NUM; k++){
				squaresPossible[i][j][k] = true;
			}
		}
	}
}

bool getPossibility(int row, int col, int num){ //get possiblity for a given square
	return squaresPossible[row][col][num-1]; //NUM-1 because arrays start at 0
}

void setPossibility(int row, int col, int num, bool possibility){ //ATTENTION: Use setSquare if you want to change a square.
	squaresPossible[row][col][num-1] = possibility; //NUM-1 because arrays start at 0
}

void setImpossibleForSquare(int row, int col, int num){ //removes num from all possibilities of other squares.
	for(int i = 0; i < SIDE_LENGTH; i++) {
		setPossibility(i, col, num, false);
	}
	for(int j = 0; j < SIDE_LENGTH; j++) {
		setPossibility(row, j, num, false);
	}
	int rowStart = row / BLOCK_LENGTH;
	int colStart = col / BLOCK_LENGTH;
	rowStart = rowStart * BLOCK_LENGTH;
	colStart = colStart * BLOCK_LENGTH;
	for(int i = rowStart; i < rowStart + BLOCK_LENGTH; i++){
		for(int j = colStart; j < colStart + BLOCK_LENGTH; j++){
			setPossibility(i, j, num, false);
		}
	}
	for(int i = 1; i < MAX_NUM+1; i++) { // as there is a number in this field set all other numbers false too.
		setPossibility(row, col, i, false);
	}
}

void removeImpossibleNumbers(int squares[SIDE_LENGTH][SIDE_LENGTH]){ //checks sudoku for the first time. Should only be called once.
	for(int i = 0; i < SIDE_LENGTH; i++) {
		for(int j = 0; j < SIDE_LENGTH; j++) {
			if(squares[i][j] != 0)
				setImpossibleForSquare(i, j, squares[i][j]);
		}
	}
}

void setSquare(int squares[SIDE_LENGTH][SIDE_LENGTH], int row, int col, int num){ //interface to set square to a number.
	squares[row][col] = num;
	setImpossibleForSquare(row, col, num);
}

bool checkForSingle(int squares[SIDE_LENGTH][SIDE_LENGTH]){ //checks if there is a single possibility in the sudoku.
	bool found = false;
	for(int i = 0; i < SIDE_LENGTH; i++){
		for(int j = 0; j < SIDE_LENGTH; j++){
			int possibleNumbersCount = 0;
			int possibleNumber = 0;
			for(int num = 1; num < MAX_NUM+1; num++){
				if(getPossibility(i,j,num)){
					possibleNumbersCount++;
					possibleNumber = num;
				}
			}
			if(possibleNumbersCount == 1){
				setSquare(squares, i, j, possibleNumber);
				found = true;
			}
		}
	}
	return found;
}

bool isFinished(int squares[SIDE_LENGTH][SIDE_LENGTH]){ //checks if there's a number in every square.
	for(int i = 0; i < SIDE_LENGTH; i++){
		for(int j = 0; j < SIDE_LENGTH; j++){
			if(squares[i][j] == 0)
				return false;
		}
	}
	return true;
}

//get next square where there still is a possibility for numbers. Returns 0 if no squares are found.
void nextPossibility(int *possibleNumbers, int possibleNumbersArr[MAX_NUM], int *nextPosRow, int *nextPosCol){
	*possibleNumbers = 0;
	*nextPosRow = 0;
	*nextPosCol = 0;
	for(int i = 0; i < SIDE_LENGTH; i++){
		for(int j = 0; j < SIDE_LENGTH; j++){
			for(int num = 1; num < MAX_NUM+1; num++){
				if(getPossibility(i,j,num)){
					possibleNumbersArr[(*possibleNumbers)] = num;
                    (*possibleNumbers)++;
				}
			}
			if((*possibleNumbers) > 0){
                (*nextPosRow) = i;
                (*nextPosCol) = j;
				return;
			}
		}
	}
}

//checks if there's only one possible number to enter in sudoku.
bool checkForOnlyPossibility(int squares[SIDE_LENGTH][SIDE_LENGTH]){
    bool morePossibilities = false;
    bool found = false;
    for(int row = 0; row < SIDE_LENGTH; row++){
        for(int col = 0; col < SIDE_LENGTH; col++){
            for(int num = 1; num < MAX_NUM+1; num++) {
                if (getPossibility(row, col, num)) { //number possible
                    int rowStart = row / BLOCK_LENGTH;
                    int colStart = col / BLOCK_LENGTH;
                    rowStart = rowStart * BLOCK_LENGTH;
                    colStart = colStart * BLOCK_LENGTH;
                    for (int i = rowStart; i < rowStart + BLOCK_LENGTH && !morePossibilities; i++) {
                        if (i != row) {
                            for (int j = 0; j < SIDE_LENGTH; j++) {
                                morePossibilities = getPossibility(i, j, num);
                            }
                        }
                    }
                    for (int j = colStart; j < colStart + BLOCK_LENGTH && !morePossibilities; j++) {
                        if (j != col) {
                            for (int i = 0; i < SIDE_LENGTH; i++) {
                                morePossibilities = getPossibility(i, j, num);
                            }
                        }
                    }
                    if (!morePossibilities) {
                        setSquare(squares, row, col, num);
                        found = true;
                    }
                }
            }
        }
    }
    return found;
}

void copySquares(int from[SIDE_LENGTH][SIDE_LENGTH], int to[SIDE_LENGTH][SIDE_LENGTH]){
	for(int i = 0; i < SIDE_LENGTH; i++){
		for(int j = 0; j < SIDE_LENGTH; j++){
			to[i][j] = from[i][j];
		}
	}
}

void copyPossibilities(int from[SIDE_LENGTH][SIDE_LENGTH][MAX_NUM], int to[SIDE_LENGTH][SIDE_LENGTH][MAX_NUM]){
	for(int i = 0; i < SIDE_LENGTH; i++){
			for(int j = 0; j < SIDE_LENGTH; j++){
				for(int k = 0; k < MAX_NUM; k++){
					to[i][j][k] = from[i][j][k];
				}
			}
		}
}

void sudoku_solve(int squares[]) { //interface according to assignment. Real work is done in sudoku_solve2.
	int squares2d[SIDE_LENGTH][SIDE_LENGTH];
	convertSudoku(squares, squares2d);
	sudoku_solve2(squares2d);
}

bool sudoku_solve2(int squares[SIDE_LENGTH][SIDE_LENGTH]) { //true if solution is found, else false
	bool solved = false;
	initSquaresPossible();
	removeImpossibleNumbers(squares);
	for(;;){
		if(!checkForSingle(squares) && !checkForOnlyPossibility(squares)) { //get desperate and guess
            int possibleNumbers;
            int possibleNumbersArr[MAX_NUM];
            int nextPosRow, nextPosCol;
            nextPossibility(&possibleNumbers, possibleNumbersArr, &nextPosRow, &nextPosCol);
            if (possibleNumbers == 0) //there are more numbers possible, but sudoku still isn't solved -- backtrack.
                return false;
            int tSquares[SIDE_LENGTH][SIDE_LENGTH];
            int tPossibilities[SIDE_LENGTH][SIDE_LENGTH][MAX_NUM];
            copyPossibilities(squaresPossible, tPossibilities); //as squaresPossible is global, backup it.
            for (int i = 0; i < possibleNumbers; i++) {
                copySquares(squares, tSquares); //backup squares
                setSquare(tSquares, nextPosRow, nextPosCol, possibleNumbersArr[i]);
                solved = sudoku_solve2(tSquares);
                copyPossibilities(tPossibilities, squaresPossible); //restore squaresPossible to global so we don't mess up.
                if(solved) return true;
            }
            return false;
        }
        if(isFinished(squares)) {
            printSudoku(squares);
            return true;
        }
	}
}

int main(int argc, char* argv[]) {
	clock_t start, end;
	double cpuTotal;
	
	int squares[SIDE_LENGTH*SIDE_LENGTH];
	if(argc != ARG_COUNT) {
        printf("Usage: %s sudoku_string\n", argv[0]);
        printf("Example: %s 530070000600195000098000060800060003400803001700020006060000280000419005000080079\n", argv[0]);
        return EXIT_FAILURE;
    } else if(strlen(argv[1]) != SIDE_LENGTH*SIDE_LENGTH) {
	    printf("Sudoku string size must be %i!", SIDE_LENGTH*SIDE_LENGTH);
        return EXIT_FAILURE;
	}
    inputNumbersIntoSudoku(squares, argv[1]);
    start = clock();
	sudoku_solve(squares);
	end = clock();
	cpuTotal = ((double) (end-start)) / CLOCKS_PER_SEC;
	printf("Time taken in seconds: %f\n", cpuTotal);
	return 0;
}