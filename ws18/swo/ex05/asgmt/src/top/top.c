//
// Created by khp on 08.11.18.
//

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "../adt/al_adt.h"

typedef struct nodeConnections* nodeConnectionsPtr_t;

struct nodeConnections{
    nodePtr_t node;
    int connections;
};

int countConnections(connectionPtr_t connectionPtr) {
    int i = 0;
    while(connectionPtr != NULL)  {
        connectionPtr = connectionPtr->nextConnection;
        i++;
    }
    return i;
}

int countNodes(nodePtr_t nodePtr) {
    int i = 0;
    while(nodePtr != NULL) {
        nodePtr = nodePtr->nextNode;
        i++;
    }
    return i;
}

void fillNodeConnections(nodePtr_t nodePtr, nodeConnectionsPtr_t nodeConnectionsPtr, int nodeCount) {
    for (int i = 0; i < nodeCount; ++i) {
        (nodeConnectionsPtr + i)->node = nodePtr;
        (nodeConnectionsPtr + i)->connections = countConnections(nodePtr->nextConnection);
        nodePtr = nodePtr->nextNode;
    }
}

void sortNodeConnections(nodeConnectionsPtr_t nodeConnectionsPtr, int nodeCount) {
    if(nodeCount <= 1)
        return;
    else {
        nodeConnectionsPtr_t left = malloc(nodeCount * sizeof(struct nodeConnections));
        nodeConnectionsPtr_t right = malloc(nodeCount * sizeof(struct nodeConnections));
        int leftMax = ceil((double)nodeCount/2);
        int rightMax = floor((double)nodeCount/2);

        for(int i = 0; i < leftMax; i++)
            *(left + i) = *(nodeConnectionsPtr + i);
        for(int i = 0; i < rightMax; i++)
            *(right + i) = *(nodeConnectionsPtr + leftMax + i);

        sortNodeConnections(left, leftMax);
        sortNodeConnections(right, rightMax);

        int leftIndex = 0;
        int rightIndex = 0;

        for(int i = 0; i < nodeCount; i++) {
            if(leftIndex >= leftMax) { //left array fully in a[]
                *(nodeConnectionsPtr + i) = *(right + rightIndex);
                rightIndex++;
            } else if(rightIndex >= rightMax) { //right array fully in a[]
                *(nodeConnectionsPtr + i) = *(left + leftIndex);
                leftIndex++;
            } else {
                if((left + leftIndex)->connections > (right + rightIndex)->connections) {
                    *(nodeConnectionsPtr + i) = *(left + leftIndex);
                    leftIndex++;
                } else {
                    *(nodeConnectionsPtr + i) = *(right + rightIndex);
                    rightIndex++;
                }
            }
        }
        free(left);
        free(right);
    }
}

nodePtr_t reconnectNodes(nodeConnectionsPtr_t nodeConnectionsPtr, int nodeCount) {
    nodePtr_t returnPtr = nodeConnectionsPtr->node;
    int i;
    for (i = 0; i < nodeCount-1; ++i) {
        nodeConnectionsPtr->node->nextNode = (nodeConnectionsPtr+1)->node;
        nodeConnectionsPtr = (nodeConnectionsPtr+1);
    }
    (nodeConnectionsPtr)->node->nextNode = NULL;
    return returnPtr;
}

nodePtr_t topological_sort(nodePtr_t nodePtr) {
    int nodeCount = countNodes(nodePtr);
    nodeConnectionsPtr_t nodeConnectionsPtr = malloc(nodeCount* sizeof(struct nodeConnections));

    fillNodeConnections(nodePtr, nodeConnectionsPtr, nodeCount);
    sortNodeConnections(nodeConnectionsPtr, nodeCount);
    nodePtr = reconnectNodes(nodeConnectionsPtr, nodeCount);
    free(nodeConnectionsPtr);
    return nodePtr;
}