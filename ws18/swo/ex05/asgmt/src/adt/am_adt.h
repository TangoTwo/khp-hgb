//
// Created by khp on 08.11.18.
//

#ifndef PROJECT_AM_ADT_H
#define PROJECT_AM_ADT_H

#include <stdbool.h>

typedef struct amStruct_t *adtPtr_t;
struct amStruct_t {
    int maxNodes;
    int nodesCount;
    char **payload;
    bool *matrix;
};

adtPtr_t init(void);

void destroy(adtPtr_t);

void createNode(adtPtr_t, char *);

bool createEdge(adtPtr_t, char *, char *);

void deleteNode(adtPtr_t, char *);

bool deleteEdge(adtPtr_t, char *, char *);

void print(adtPtr_t);

#endif //PROJECT_AM_ADT_H
