#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include "stackoperm.h"

#define TEAM_SIZE 4
#define ARGUMENTS 1

const int AMOUNT_TEAMS;

typedef struct runner runner;
typedef struct team team;

void sortRunnerArray(runner *runnerArray[], int length);

struct runner {
    int ID;
    float bestTime;
};

struct team {
    int ID;
    runner *runners[TEAM_SIZE];
    double time;
};

bool checkArgs(int argc, char* argv[]){
    int amountRunners = argc-ARGUMENTS;
    if(argc == 1){
        printf("Usage: %s [runner_time]\n", argv[0]);
        printf("Example: %s 10.5 10.3 ...\n", argv[0]);
        return false;
    }
    if((amountRunners%TEAM_SIZE) != 0){
        printf("Amount of runners (%i) must be divideable by the team size = %i", amountRunners, TEAM_SIZE);
        return false;
    }
    return true;
}

void initRunnerArray(runner *runnerArray[], int length){
    for (int i = 0; i < length; ++i) {
        runner* runner = malloc(sizeof(*runner));
        runnerArray[i] = runner;
    }
}

void copyRunnerArray(runner *from[], runner *to[], int length){
    for (int i = 0; i < length; ++i) {
        to[i] = from[i];
    }
}

void copyTeamArray(team from[], team to[], int length){
    for (int i = 0; i < length; ++i) {
        to[i] = from[i];
    }
}

void printTeamArray(team teamArray[], int length){
    for (int i = 0; i < length; ++i) {
        for (int j = 0; j < TEAM_SIZE; ++j) {
            printf("Team %i - Runner %i\n", teamArray[i].ID, teamArray[i].runners[j]->ID);
        }
        printf("With time: %f\n\n", teamArray[i].time);
    }
}

int removeRunnerFromArray(runner *from[], runner *to[], int index, int length){
    int toLength = length-1;
    copyRunnerArray(from, to, length);
    to[index] = from[length-1];
    sortRunnerArray(to, toLength);
    return toLength;
}

void fillRunnerArrayArg(runner *runnerArray[], char* argv[], int argc){
    initRunnerArray(runnerArray, argc-ARGUMENTS);
    for(int i = 0; i < argc-ARGUMENTS; i++){
        runnerArray[i]->ID = i;
        runnerArray[i]->bestTime = atof(argv[i+ARGUMENTS]);
    }
}

void initTeamArray(team *teamArray, int amountTeams){
    for(int i = 0; i < amountTeams; i++) {
        teamArray[i].ID = i;
        for (int j = 0; j < TEAM_SIZE; ++j) {
            teamArray[i].runners[j] = NULL;
        }
        teamArray[i].time = 0;
    }
}

void sortRunnerArray(runner *runnerArray[], int length){
    if(length <= 1)
        return;
    runner *left[length];
    runner *right[length];
    int leftMax = ceil((double)length/2);
    int rightMax = floor((double)length/2);

    for(int i = 0; i < leftMax; i++)
        left[i] = runnerArray[i];
    for(int i = 0; i < rightMax; i++)
        right[i] = runnerArray[leftMax + i];

    sortRunnerArray(left, leftMax);
    sortRunnerArray(right, rightMax);

    int leftIndex = 0;
    int rightIndex = 0;

    for(int i = 0; i < length; i++) {
        if (leftIndex >= leftMax) { //left array fully in a[]
            runnerArray[i] = right[rightIndex];
            rightIndex++;
        } else if (rightIndex >= rightMax) { //right array fully in a[]
            runnerArray[i] = left[leftIndex];
            leftIndex++;
        } else {
            if (left[leftIndex]->bestTime > right[rightIndex]->bestTime) {
                runnerArray[i] = left[leftIndex];
                leftIndex++;
            } else {
                runnerArray[i] = right[rightIndex];
                rightIndex++;
            }
        }
    }
}

void getBestDistribution2(runner *runnerArray[], team teamArray[], int AMOUNT_RUNNERS, int AMOUNT_TEAMS){
    runner *tRunnerArray[AMOUNT_RUNNERS];
    team tTeamArray[AMOUNT_TEAMS];

    int tRunnerArrayLength;

    for (int i = 0; i < AMOUNT_RUNNERS; ++i) {
        tRunnerArrayLength = removeRunnerFromArray(runnerArray, tRunnerArray, i, AMOUNT_RUNNERS);
        for (int j = 0; j < AMOUNT_TEAMS; ++j) {
            copyTeamArray(teamArray, tTeamArray, AMOUNT_TEAMS);
            bool success = false;
            for (int k = 0; k < TEAM_SIZE && !success; ++k) {
                if (tTeamArray[j].runners[k] == NULL) {
                    tTeamArray[j].runners[k] = runnerArray[i];
                    success = true;
                }
            }
            if (!success)
                return;
            getBestDistribution2(tRunnerArray, tTeamArray, tRunnerArrayLength, AMOUNT_TEAMS);
        }
    }
}

void getBestDistribution(runner *runnerArray[], team teamArray[], int AMOUNT_RUNNERS, int AMOUNT_TEAMS){
    unsigned long long p = pnk(AMOUNT_RUNNERS, AMOUNT_RUNNERS);
    printf ("\n total permutations : %llu\n\n", p);

    permute(runnerArray, 0, AMOUNT_RUNNERS);
}

int main(int argc, char* argv[]) {
    if(!checkArgs(argc, argv)){
        return EXIT_FAILURE;
    }

    const int AMOUNT_RUNNERS = argc-ARGUMENTS;
    const int AMOUNT_TEAMS = AMOUNT_RUNNERS / TEAM_SIZE;
    runner *runnerArray[AMOUNT_RUNNERS];
    team teamArray[AMOUNT_TEAMS];

    fillRunnerArrayArg(runnerArray, argv, argc);
    initTeamArray(teamArray, AMOUNT_TEAMS);

    sortRunnerArray(runnerArray, AMOUNT_RUNNERS);

    getBestDistribution(runnerArray, teamArray, AMOUNT_RUNNERS, AMOUNT_TEAMS);
    return EXIT_SUCCESS;
}