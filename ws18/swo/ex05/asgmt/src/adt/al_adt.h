//
// Created by khp on 08.11.18.
//

#ifndef PROJECT_AL_ADT_H
#define PROJECT_AL_ADT_H

#include <stdbool.h>

typedef struct node *adtPtr_t;
typedef struct connection *connectionPtr_t;
struct node {
    char *payload;
    connectionPtr_t nextConnection;
    adtPtr_t nextNode;
};
struct connection {
    adtPtr_t node;
    connectionPtr_t nextConnection;
};

adtPtr_t init(void);

void destroy(adtPtr_t);

void createNode(adtPtr_t, char *);

bool createEdge(adtPtr_t, char *, char *);

void deleteNode(adtPtr_t, char *);

bool deleteEdge(adtPtr_t, char *, char *);

void print(adtPtr_t);

#endif //PROJECT_AL_ADT_H
