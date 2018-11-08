//
// Created by khp on 05.11.18.
//

#include <stdlib.h>
#include <stdio.h>
#include "list_ads.h"

typedef struct node *nodePtr;
typedef struct node{
    nodePtr next;
    int     value;
} node;
typedef nodePtr listT;

static listT list;

static nodePtr newNode(int value, nodePtr next){
    nodePtr n = (nodePtr)malloc(sizeof(node));
    if(n == NULL) {
        printf("Out of memory!");
        exit(1);
    }

    n->value = value;
    n->next = next;

    return n;
}

void init(void) {
    list = NULL;
}

void prepend(int value) {
    node *n = newNode(value, list);
    list = n;
}

void print(void) {
    nodePtr n = list;

    while (n != NULL) {
        printf("%d ", n->value);
        n = n->next;
    }
    printf("\n");
}

void forEach(funcT f) {
    nodePtr n = list;

    while (n != NULL) {
        f(n->value);
        n = n->next;
    }
}

void destroy(void) {
    nodePtr n = list;

    while (n != NULL) {
        nodePtr succ = n->next;
        free(n);
        n = succ;
    }
}