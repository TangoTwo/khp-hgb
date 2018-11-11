//
// Created by khp on 08.11.18.
//

#ifndef PROJECT_AL_ADT_H
#define PROJECT_AL_ADT_H

#include <stdbool.h>

typedef struct node* nodePtr_t;
typedef struct connection* connectionPtr_t;
struct node {
    char* payload;
    connectionPtr_t nextConnection;
    nodePtr_t nextNode;
};
struct connection{
    nodePtr_t node;
    connectionPtr_t nextConnection;
};

nodePtr_t initAL(void);
void destroyAL(nodePtr_t);
void createNodeAL(nodePtr_t, char*);
bool createEdgeAL(nodePtr_t, char*, char*);
void deleteNodeAL(nodePtr_t, char*);
bool deleteEdgeAL(nodePtr_t, char*, char*);
void printAL(nodePtr_t);

#endif //PROJECT_AL_ADT_H
