//
// Created by khp on 08.11.18.
//

#include <stdlib.h>
#include "../adt/am_adt.h"
#include "../adt/al_adt.h"
#include "top.h"

int main() {
    nodePtr_t originNodePtr = initAL();
    createNodeAL(originNodePtr, "A");
    createNodeAL(originNodePtr, "B");
    createNodeAL(originNodePtr, "C");
    createNodeAL(originNodePtr, "D");
    createNodeAL(originNodePtr, "E");
    createEdgeAL(originNodePtr, "A", "B");
    createEdgeAL(originNodePtr, "A", "C");
    createEdgeAL(originNodePtr, "A", "D");
    createEdgeAL(originNodePtr, "A", "E");
    createEdgeAL(originNodePtr, "B", "D");
    createEdgeAL(originNodePtr, "C", "B");
    createEdgeAL(originNodePtr, "C", "E");
    originNodePtr = topological_sort(originNodePtr);
    printAL(originNodePtr);
    destroyAL(originNodePtr);
}