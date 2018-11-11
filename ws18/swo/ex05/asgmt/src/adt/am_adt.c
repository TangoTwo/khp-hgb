//
// Created by khp on 08.11.18.
//
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "am_adt.h"

#define INITIAL_SIZE 2
#define SIZE_MULTIPLIER 2

int mapPayloadToIndex(char **payload, char *searched, int nodesCount) {
    for (int i = 0; i < nodesCount; ++i) {
        if (strcmp(*(payload + i), searched) == 0) {
            return i;
        }
    }
    return -1;
}

void copyPayload(char **from, char **to, int size) {
    for (int i = 0; i < size; ++i) {
        *(to + i) = *(from + i);
    }
}

bool *mapIndexToAddr(bool *matrix, int from, int to, int nodesCount, int maxNodes) {
    if (from > nodesCount || to > nodesCount) {
        printf("Invalid index!");
        return NULL;
    }
    bool *memAddr = matrix + (from * maxNodes) + to;
    return memAddr;
}

void copyMatrix(bool *from, int fromMaxNodes, bool *to, int toMaxNodes, int nodesCount) {
    for (int i = 0; i < (nodesCount); ++i) {
        for (int j = 0; j < nodesCount; ++j) {
            *mapIndexToAddr(to, i, j, nodesCount, toMaxNodes) = *mapIndexToAddr(from, i, j, nodesCount, fromMaxNodes);
        }
    }
}

void resizeAM(adtPtr_t amPtr, int size) { //extra ned im Header
    char **oldPayload = amPtr->payload;
    bool *oldMatrix = amPtr->matrix;
    int oldMaxNodes = amPtr->maxNodes;
    amPtr->maxNodes = size;
    amPtr->payload = (char **) malloc((unsigned int)amPtr->maxNodes * sizeof(char *));
    amPtr->matrix = (bool *) malloc((unsigned int)(amPtr->maxNodes * amPtr->maxNodes) * sizeof(bool));
    copyPayload(oldPayload, amPtr->payload, amPtr->nodesCount);
    copyMatrix(oldMatrix, oldMaxNodes, amPtr->matrix, amPtr->maxNodes, amPtr->nodesCount);
    free(oldMatrix);
    free(oldPayload);
}

adtPtr_t init(void) {
    adtPtr_t amPtr = malloc(sizeof(struct amStruct_t));
    amPtr->nodesCount = 0;
    resizeAM(amPtr, INITIAL_SIZE);
    return amPtr;
}

void destroy(adtPtr_t amPtr) {
    for (int i = 0; i < amPtr->nodesCount; ++i) {
        free(*(amPtr->payload + i));
    }
    free(amPtr->payload);
    free(amPtr->matrix);
    free(amPtr);
}

void createNode(adtPtr_t amPtr, char *name) {
    char *tString = malloc(strlen(name) * sizeof(char));
    strcpy(tString, name);
    if (amPtr->nodesCount == amPtr->maxNodes) {
        resizeAM(amPtr, amPtr->maxNodes * SIZE_MULTIPLIER);
    }
    *(amPtr->payload + amPtr->nodesCount) = tString;
    amPtr->nodesCount++;

    for (int i = 0; i < amPtr->nodesCount; ++i) {
        *(mapIndexToAddr(amPtr->matrix, amPtr->nodesCount, i, amPtr->nodesCount, amPtr->maxNodes)) = false;
    }
    for (int i = 0; i < amPtr->nodesCount; ++i) {
        *(mapIndexToAddr(amPtr->matrix, i, amPtr->nodesCount, amPtr->nodesCount, amPtr->maxNodes)) = false;
    }
}

bool createEdge(adtPtr_t amPtr, char *from, char *to) {
    int fromIndex = mapPayloadToIndex(amPtr->payload, from, amPtr->nodesCount);
    int toIndex = mapPayloadToIndex(amPtr->payload, to, amPtr->nodesCount);
    if (fromIndex == -1) {
        printf("%s does not exist!", from);
        return false;
    } else if (toIndex == -1) {
        printf("%s does not exist!", to);
        return false;
    }

    *mapIndexToAddr(amPtr->matrix, fromIndex, toIndex, amPtr->nodesCount, amPtr->maxNodes) = true;
    return true;
}

void deleteNode(adtPtr_t amPtr, char *name) {
    //swap with last index and reduce nodesCount
    int removeIndex = mapPayloadToIndex(amPtr->payload, name, amPtr->nodesCount);
    if (removeIndex == -1) {
        printf("%s does not exist!", name);
    }
    for (int i = 0; i < amPtr->nodesCount; ++i) {
        *(mapIndexToAddr(amPtr->matrix, removeIndex, i, amPtr->nodesCount, amPtr->maxNodes)) = *(mapIndexToAddr(
                amPtr->matrix, amPtr->nodesCount - 1, i, amPtr->nodesCount, amPtr->maxNodes));
    }
    for (int i = 0; i < amPtr->nodesCount; ++i) {
        *(mapIndexToAddr(amPtr->matrix, i, removeIndex, amPtr->nodesCount, amPtr->maxNodes)) = *(mapIndexToAddr(
                amPtr->matrix, i, amPtr->nodesCount - 1, amPtr->nodesCount, amPtr->maxNodes));
    }
    *(amPtr->payload + removeIndex) = *(amPtr->payload + (amPtr->nodesCount - 1));
    free(*(amPtr->payload + (amPtr->nodesCount)));
    amPtr->nodesCount--;
}

bool deleteEdge(adtPtr_t amPtr, char *from, char *to) {
    int fromIndex = mapPayloadToIndex(amPtr->payload, from, amPtr->nodesCount);
    int toIndex = mapPayloadToIndex(amPtr->payload, to, amPtr->nodesCount);
    if (fromIndex == -1) {
        printf("%s does not exist!", from);
        return false;
    } else if (toIndex == -1) {
        printf("%s does not exist!", to);
        return false;
    }

    *mapIndexToAddr(amPtr->matrix, fromIndex, toIndex, amPtr->nodesCount, amPtr->maxNodes) = false;
    return true;
}

void print(adtPtr_t amPtr) {
    printf("    ");
    for (int k = 0; k < amPtr->nodesCount; ++k) {
        printf("%s", *(amPtr->payload + k));
    }
    printf("\n");
    for (int i = 0; i < amPtr->nodesCount; ++i) {
        printf("%s | ", *(amPtr->payload + i));
        for (int j = 0; j < amPtr->nodesCount; ++j) {
            printf("%i", *(mapIndexToAddr(amPtr->matrix, i, j, amPtr->nodesCount, amPtr->maxNodes)));
        }
        printf("\n");
    }
}
