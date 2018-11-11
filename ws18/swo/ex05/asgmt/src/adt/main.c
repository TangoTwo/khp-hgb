//
// Created by khp on 08.11.18.
//

#include <stdlib.h>
#include "am_adt.h"
#include "al_adt.h"
#include "../top/top.h"

int main() {

    amPtr_t amPtr = initAM();
    createNodeAM(amPtr, "A");
    createNodeAM(amPtr, "B");
    createNodeAM(amPtr, "C");
    createNodeAM(amPtr, "D");
    createNodeAM(amPtr, "E");
    createEdgeAM(amPtr, "A", "B");
    createEdgeAM(amPtr, "A", "C");
    createEdgeAM(amPtr, "A", "D");
    createEdgeAM(amPtr, "A", "E");
    createEdgeAM(amPtr, "B", "D");
    createEdgeAM(amPtr, "C", "B");
    createEdgeAM(amPtr, "C", "E");
    printAM(amPtr);
    deleteEdgeAM(amPtr, "A", "B");
    deleteNodeAM(amPtr, "C");
    printAM(amPtr);
    destroyAM(amPtr);

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
    printAL(originNodePtr);
    deleteEdgeAL(originNodePtr, "A", "B");
    deleteNodeAL(originNodePtr, "C");
    printAL(originNodePtr);
    destroyAL(originNodePtr);
}