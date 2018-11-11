//
// Created by khp on 08.11.18.
//

#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "al_adt.h"

void initNode(nodePtr_t nodePtr) {
    nodePtr->payload = "";
    nodePtr->nextConnection = NULL;
    nodePtr->nextNode = NULL;
}

nodePtr_t initAL(void) {
    nodePtr_t newNode = malloc(sizeof(struct node));
    initNode(newNode);
    return newNode;
}

void createNodeAL(nodePtr_t nodePtr, char *name) {
    if (nodePtr->payload == "") { //first element
        nodePtr->payload = name;
        return;
    }
    nodePtr_t newNode = malloc(sizeof(struct node));
    initNode(newNode);
    newNode->payload = name;
    while (nodePtr->nextNode != NULL)
        nodePtr = nodePtr->nextNode;
    nodePtr->nextNode = newNode;
}

nodePtr_t getNodePtr(nodePtr_t nodePtr, char *name) {
    while (nodePtr != NULL) {
        if (strcmp(nodePtr->payload, name) == 0) {
            return nodePtr;
        }
        nodePtr = nodePtr->nextNode;
    }
    return NULL;
}

bool createEdgeAL(nodePtr_t nodePtr, char *from, char *to) {
    nodePtr_t fromPtr;
    nodePtr_t toPtr;
    connectionPtr_t newConnection = malloc(sizeof(struct connection));
    newConnection->nextConnection = NULL;
    fromPtr = getNodePtr(nodePtr, from);
    toPtr = getNodePtr(nodePtr, to);

    if (fromPtr == NULL) {
        printf("%s does not exist!\n", from);
        return false;
    }
    if (toPtr == NULL) {
        printf("%s does not exist!\n", to);
        return false;
    }

    newConnection->node = toPtr;

    if (fromPtr->nextConnection == NULL) {
        fromPtr->nextConnection = newConnection;
    } else {
        connectionPtr_t fromConnection = fromPtr->nextConnection;
        while (fromConnection->nextConnection != NULL)
            fromConnection = fromConnection->nextConnection;

        fromConnection->nextConnection = newConnection;
    }
}

void deleteConnectionList(connectionPtr_t connectionPtr) {
    if (connectionPtr != NULL) {
        deleteConnectionList(connectionPtr->nextConnection);
        free(connectionPtr);
    }
}

void deleteNodeByPtrAL(nodePtr_t originPtr, nodePtr_t delPtr) {
    nodePtr_t tPtr = originPtr;
    while (tPtr->nextNode != delPtr)
        tPtr = tPtr->nextNode;

    tPtr->nextNode = tPtr->nextNode->nextNode;

    tPtr = originPtr;
    while (tPtr->nextNode != NULL) {
        connectionPtr_t nextConnection = tPtr->nextConnection;
        connectionPtr_t curConnection = tPtr;
        bool finished = false;
        while (nextConnection != NULL) {
            if (nextConnection->node == delPtr) {
                connectionPtr_t tConnection = nextConnection;
                curConnection->nextConnection = nextConnection->nextConnection;
                free(tConnection);
                finished = true;
            }
            if (finished == true)
                break;
            curConnection = nextConnection;
            nextConnection = nextConnection->nextConnection;
        }
        tPtr = tPtr->nextNode;
    }

    deleteConnectionList(delPtr->nextConnection);
    free(delPtr);
}

void deleteNodeAL(nodePtr_t nodePtr, char *name) {
    nodePtr_t namePtr;
    nodePtr_t originPtr = nodePtr;

    namePtr = getNodePtr(nodePtr, name);

    if (namePtr == NULL) {
        printf("Name does not exist!\n");
    }

    deleteNodeByPtrAL(originPtr, namePtr);
}

bool deleteEdgeAL(nodePtr_t nodePtr, char *from, char *to) {
    nodePtr_t fromPtr;
    nodePtr_t toPtr;

    fromPtr = getNodePtr(nodePtr, from);
    toPtr = getNodePtr(nodePtr, to);

    if (fromPtr == NULL) {
        printf("%s does not exist!\n", from);
        return false;
    }
    if (toPtr == NULL) {
        printf("%s does not exist!\n", to);
        return false;
    }

    connectionPtr_t curConnection = fromPtr;
    while (curConnection != NULL) {
        connectionPtr_t nextConnection = curConnection->nextConnection;
        bool finished = false;
        if (nextConnection != NULL) {
            if (nextConnection->node == toPtr) {
                curConnection->nextConnection = nextConnection->nextConnection;
                free(nextConnection);
                finished = true;
            }
        }
        if (finished == true)
            return true;
        curConnection = curConnection->nextConnection;
    }
    return false;
}

void printAL(nodePtr_t node) {
    while (node != NULL) {
        printf("%s : ", node->payload);
        connectionPtr_t nextConnection = node->nextConnection;
        while (nextConnection != NULL) {
            printf("%s ", nextConnection->node->payload);
            nextConnection = nextConnection->nextConnection;
        }
        printf("\n");
        node = node->nextNode;
    }
}

void destroyAL(nodePtr_t node){
    if(node != NULL) {
        destroyAL(node->nextNode);
        deleteConnectionList(node->nextConnection);
        free(node);
    }
}