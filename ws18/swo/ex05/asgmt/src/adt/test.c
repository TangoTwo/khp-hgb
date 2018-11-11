//
// Created by khp on 08.11.18.
//

#if USE_LIST
#include "al_adt.h"
#if SORT
#include "../top/top.h"
#endif
#else
#include "am_adt.h"
#endif

#include <stdlib.h>
#include <stdio.h>

int main() {
    printf("## ORIGINAL ARRAY ##\n");
    adtPtr_t adtPtr = init();
    createNode(adtPtr, "A");
    createNode(adtPtr, "B");
    createNode(adtPtr, "C");
    createNode(adtPtr, "D");
    createNode(adtPtr, "E");
    createEdge(adtPtr, "A", "B");
    createEdge(adtPtr, "A", "C");
    createEdge(adtPtr, "A", "D");
    createEdge(adtPtr, "A", "E");
    createEdge(adtPtr, "B", "D");
    createEdge(adtPtr, "C", "B");
    createEdge(adtPtr, "C", "E");
    print(adtPtr);

    printf("\n\n## TEST 1 - REMOVAL OF 1 NODE ##\n");
    deleteNode(adtPtr, "E");
    printf("REMOVED 1 NODE (E):\n");
    print(adtPtr);
    destroy(adtPtr);

    printf("\n\n## TEST 2 - REMOVAL OF 1 EDGE ##\n");
    adtPtr = init();
    createNode(adtPtr, "A");
    createNode(adtPtr, "B");
    createNode(adtPtr, "C");
    createNode(adtPtr, "D");
    createNode(adtPtr, "E");
    createEdge(adtPtr, "A", "B");
    createEdge(adtPtr, "A", "C");
    createEdge(adtPtr, "A", "D");
    createEdge(adtPtr, "A", "E");
    createEdge(adtPtr, "B", "D");
    createEdge(adtPtr, "C", "B");
    createEdge(adtPtr, "C", "E");
    deleteEdge(adtPtr, "C", "E");
    printf("REMOVED 1 EDGE (C-E):\n");
    print(adtPtr);
    destroy(adtPtr);

    printf("\n\n## TEST 3 - REMOVAL OF 1 NODE (NOT EXISTING) ##\n");
    adtPtr = init();
    createNode(adtPtr, "A");
    createNode(adtPtr, "B");
    createNode(adtPtr, "C");
    createNode(adtPtr, "D");
    createNode(adtPtr, "E");
    createEdge(adtPtr, "A", "B");
    createEdge(adtPtr, "A", "C");
    createEdge(adtPtr, "A", "D");
    createEdge(adtPtr, "A", "E");
    createEdge(adtPtr, "B", "D");
    createEdge(adtPtr, "C", "B");
    createEdge(adtPtr, "C", "E");
    deleteNode(adtPtr, "X");
    printf("THROWS ERROR, DOESN'T ALTER NODES\n");
    print(adtPtr);
    destroy(adtPtr);

    printf("\n\n## TEST 4 - REMOVAL OF 1 EDGE (NOT EXISTING) ##\n");
    adtPtr = init();
    createNode(adtPtr, "A");
    createNode(adtPtr, "B");
    createNode(adtPtr, "C");
    createNode(adtPtr, "D");
    createNode(adtPtr, "E");
    createEdge(adtPtr, "A", "B");
    createEdge(adtPtr, "A", "C");
    createEdge(adtPtr, "A", "D");
    createEdge(adtPtr, "A", "E");
    createEdge(adtPtr, "B", "D");
    createEdge(adtPtr, "C", "B");
    createEdge(adtPtr, "C", "E");
    deleteEdge(adtPtr, "X", "Y");
    printf("THROWS ERROR, DOESN'T ALTER NODES\n");
    print(adtPtr);
    destroy(adtPtr);

    printf("\n\n## TEST 5 - PRINTING EMTPY ARRAY ##\n");
    adtPtr = init();
    printf("PRINTS EMPTY ARRAY\n");
    print(adtPtr);
    destroy(adtPtr);

#if SORT
    printf("\n\n## TEST 6 - SORTING ##\n");
    adtPtr = init();
    createNode(adtPtr, "A");
    createNode(adtPtr, "B");
    createNode(adtPtr, "C");
    createNode(adtPtr, "D");
    createNode(adtPtr, "E");
    createEdge(adtPtr, "A", "B");
    createEdge(adtPtr, "A", "C");
    createEdge(adtPtr, "A", "D");
    createEdge(adtPtr, "A", "E");
    createEdge(adtPtr, "B", "D");
    createEdge(adtPtr, "C", "B");
    createEdge(adtPtr, "C", "E");
    printf("SORTING ARRAY:\n");
    topological_sort(adtPtr);
    print(adtPtr);

    printf("\n\n## TEST 7 - SORTING - SAME AMOUNT OF NODES ##\n");
    adtPtr = init();
    createNode(adtPtr, "A");
    createNode(adtPtr, "B");
    createNode(adtPtr, "C");
    createNode(adtPtr, "D");
    createNode(adtPtr, "E");
    createEdge(adtPtr, "A", "B");
    createEdge(adtPtr, "A", "C");
    createEdge(adtPtr, "A", "D");
    createEdge(adtPtr, "A", "E");
    createEdge(adtPtr, "B", "D");
    createEdge(adtPtr, "B", "E");
    createEdge(adtPtr, "C", "B");
    createEdge(adtPtr, "C", "E");
    printf("SORTING ARRAY:\n");
    topological_sort(adtPtr);
    print(adtPtr);

    printf("\n\n## TEST 8 - SORTING - NO CONNECTIONS ##\n");
    adtPtr = init();
    createNode(adtPtr, "A");
    createNode(adtPtr, "B");
    createNode(adtPtr, "C");
    createNode(adtPtr, "D");
    createNode(adtPtr, "E");
    printf("SORTING ARRAY:\n");
    topological_sort(adtPtr);
    print(adtPtr);
#endif
}