//
// Created by khp on 08.11.18.
//

#ifndef PROJECT_AM_ADT_H
#define PROJECT_AM_ADT_H

#include <stdbool.h>

typedef struct amStruct_t* amPtr_t;
struct amStruct_t{
    unsigned int maxNodes;
    unsigned int nodesCount;
    char** payload;
    bool* matrix;
};

amPtr_t initAM(void);
void destroyAM(amPtr_t);
void createNodeAM(amPtr_t, char*);
bool createEdgeAM(amPtr_t, char*, char*);
void deleteNodeAM(amPtr_t, char*);
bool deleteEdgeAM(amPtr_t, char*, char*);
void printAM(amPtr_t);

#endif //PROJECT_AM_ADT_H
