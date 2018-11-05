#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include <limits.h>

#define TEAM_SIZE 4
#define ARGUMENTS 1
#define MAX 1000

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

void calcSum(team teamArray[], int index) {
    teamArray[index].time = 0;
    for (int i = 0; i < TEAM_SIZE; ++i) {
        teamArray[index].time += teamArray[index].runners[i]->bestTime;
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
    runner *left[MAX];
    runner *right[MAX];
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

void getAllPossibleTeams(runner *runnerArray[], team possibleTeams[], int AMOUNT_RUNNERS, int* amount_teams) {
    runner *tRunnerArray[MAX];
    team tCurTeam;

    for (int j = 0; j < TEAM_SIZE; ++j) {
        tCurTeam.runners[j] = NULL;
    }
    tCurTeam.time = 0;

    for (int i = 0; i < AMOUNT_RUNNERS; ++i) {
        bool success = false;
        runner* currentRunner = runnerArray[i];
        int tAmountRunners = removeRunnerFromArray(runnerArray, tRunnerArray, i, AMOUNT_RUNNERS);
        for (int j = 0; j < TEAM_SIZE; ++j) {
            if(tCurTeam.runners[j] == NULL) {
                tCurTeam.runners[j] = currentRunner;
                success = true;
            }
        }
        if(success)
            getAllPossibleTeams(tRunnerArray, possibleTeams, tAmountRunners, amount_teams);
        else{//TEAM is full
            possibleTeams[*amount_teams+1] = tCurTeam;
            *amount_teams++;
            return;
        }
    }
}

void getBestDistribution(runner *runnerArray[], team teamArray[], int AMOUNT_RUNNERS, int AMOUNT_TEAMS){
    team tTeamArray[MAX];
    double bestDiff = LONG_MAX;
    team bestTeamDist[MAX];

    for (int i = 0; i < 1000; ++i) {
        double sumDiff = 0;
        copyTeamArray(teamArray, tTeamArray, AMOUNT_TEAMS);
        //SWAP TEAMS
        for (int j = 0; j < AMOUNT_TEAMS; ++j) {
            sumDiff += tTeamArray[j].time;
        }
        if(sumDiff < bestDiff) {
            bestDiff = sumDiff;
            copyTeamArray(tTeamArray, bestTeamDist, AMOUNT_TEAMS);
        }
    }
}

int main(int argc, char* argv[]) {
    if(!checkArgs(argc, argv)){
        return EXIT_FAILURE;
    }

    const int AMOUNT_RUNNERS = argc-ARGUMENTS;
    const int AMOUNT_TEAMS = AMOUNT_RUNNERS / TEAM_SIZE;
    runner *runnerArray[MAX];
    team teamArray[MAX];

    fillRunnerArrayArg(runnerArray, argv, argc);
    initTeamArray(teamArray, AMOUNT_TEAMS);

    sortRunnerArray(runnerArray, AMOUNT_RUNNERS);

    //getBestDistribution(runnerArray, teamArray, AMOUNT_RUNNERS, AMOUNT_TEAMS);
    team possibleTeams[MAX];
    int amountTeams = 0;
    getAllPossibleTeams(runnerArray, possibleTeams, AMOUNT_RUNNERS, &amountTeams);
    return EXIT_SUCCESS;
}
