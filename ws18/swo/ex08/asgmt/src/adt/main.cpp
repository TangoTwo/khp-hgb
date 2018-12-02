//
// Created by khp on 01.12.18.
//

#include "vertexT.h"
#include "graphT.h"

int main() {
    graph_t graph;
    graph.print(std::cout) << std::endl;
    vertex_t vertex1;
    vertex_t vertex2;
    vertex_t vertex3;

    vertex1.name = "A";
    vertex2.name = "B";
    vertex3.name = "C";

    // Hinzufügen eines Vertexes zu einem Graphen.
    handle_t handleV1 = graph.addVertex(vertex1);
    handle_t handleV2 = vertex2 >> graph;
    std::cout << graph << std::endl;

    // Hinzufügen eines Edges zu einem Graphen
    graph.addEdge(handleV1, handleV2, 200);
    std::cout << graph << std::endl;

    // Hinzufügen eines Vertexes und eines Edges zu einem Graphen.
    handle_t handleV3 = graph.addVertex(vertex3);
    graph.addEdge(handleV3, handleV1, 29);
    std::cout << graph << std::endl;

    // Entfernen eines Vertexes über den Handle
    graph.removeVertex(handleV2);
    std::cout << graph << std::endl;

    // Es ist auch möglich einen Vertex öfter in einen Graphen zu geben.
    handleV2 = graph.addVertex(vertex2);
    handle_t handleV4 = graph.addVertex(vertex2);
    graph.addEdge(handleV2, handleV4, 40);
    graph.addEdge(handleV4, handleV2, 40);
    std::cout << graph << std::endl;

    // Berechnung des kürzesten Weges
    std::cout << "Shortest connection C-A (29):" << graph.getShortestPath(handleV3, handleV1) << std::endl;
    std::cout << "Shortest connection B1-B2 (40):" << graph.getShortestPath(handleV2, handleV4) << std::endl;
    std::cout << "Shortest connection A-B (-1, NO PATH):" << graph.getShortestPath(handleV1, handleV4) << std::endl;
}