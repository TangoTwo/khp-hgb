//
// Created by khp on 01.12.18.
//

#ifndef SWO_GRAPHT_H
#define SWO_GRAPHT_H

#include <iostream>
#include <vector>
#include <map>
#include "handleT.h"
#include "vertexT.h"

class graph_t {
    friend std::ostream &operator<<(std::ostream &os, const graph_t &graph);
    friend handle_t operator>>(vertex_t &vertex, graph_t &graph);
public:
    handle_t addVertex(vertex_t vertex);
    void removeVertex(handle_t handle);
    void addEdge(handle_t const from, handle_t const to, int const weight);
    void removeEdge(handle_t const from, handle_t const to);
    int getShortestPath(handle_t const from, handle_t const to) const;
    std::ostream & print (std::ostream &out) const;

private:
    long unsigned int getIndex(handle_t) const;
    long unsigned int getHandlesIndex(handle_t handle, std::vector<std::pair<handle_t, int>> handles) const;
    static bool sortByDist(const std::pair<handle_t, int> &a, const std::pair<handle_t, int> &b);
    std::vector<std::vector<int>> _adjacencies{};
    std::vector<handle_t> _nodes{};
    std::map<unsigned long int, vertex_t> _handleMap{};
};
std::ostream &operator<<(std::ostream &os, const graph_t &graph);
handle_t operator>>(vertex_t &vertex, graph_t &graph);

#endif //SWO_GRAPHT_H
