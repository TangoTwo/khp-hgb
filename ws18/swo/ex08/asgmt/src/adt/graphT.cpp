//
// Created by khp on 01.12.18.
//

#include <algorithm>
#include "graphT.h"

#define INVALID_NODE -1
#define INVALID_HANDLE -2
#define NO_PATH INT16_MAX

handle_t graph_t::addVertex(vertex_t vertex) {
    handle_t tHandle(rand());
    while (_handleMap.find(tHandle.getID()) != _handleMap.end()) { // ID does not exist yet
        handle_t tHandle2(rand());
        tHandle = tHandle2;
    }
    _handleMap.insert({tHandle.getID(), vertex});
    for (long unsigned int i = 0; i < _adjacencies.size(); ++i) {
        _adjacencies[i].push_back(0);
    }
    std::vector<int> tVec(_adjacencies.size() + 1, 0);
    _adjacencies.push_back(tVec);
    _nodes.push_back(tHandle);
    return tHandle;
}

void graph_t::removeVertex(handle_t handle) {
    auto idx = _handleMap.find(handle.getID());
    if (idx == _handleMap.end()) {
        std::cout << "Vertex not found!" << std::endl;
        return;
    }

    long unsigned int index = getIndex(handle);
    for (long unsigned int i = 0; i < _adjacencies.size(); ++i) {
        _adjacencies[i].erase(_adjacencies[i].begin() + index);
    }
    _adjacencies.erase(_adjacencies.begin() + index);
    _nodes.erase(_nodes.begin() + index);
    _handleMap.erase(handle.getID());
}

void graph_t::addEdge(handle_t const from, handle_t const to, int const weight) {
    auto idxFrom = _handleMap.find(from.getID());
    if (idxFrom == _handleMap.end()) {
        std::cout << "Vertex from not found!" << std::endl;
        return;
    }

    auto idxTo = _handleMap.find(to.getID());
    if (idxTo == _handleMap.end()) {
        std::cout << "Vertex to not found!" << std::endl;
        return;
    }

    long unsigned int indexFrom = getIndex(from);
    long unsigned int indexTo = getIndex(to);
    _adjacencies[indexFrom][indexTo] = weight;
}

void graph_t::removeEdge(handle_t const from, handle_t const to) {
    auto idxFrom = _handleMap.find(from.getID());
    if (idxFrom == _handleMap.end()) {
        std::cout << "Vertex from not found!" << std::endl;
        return;
    }

    auto idxTo = _handleMap.find(to.getID());
    if (idxTo == _handleMap.end()) {
        std::cout << "Vertex to not found!" << std::endl;
        return;
    }
    long unsigned int indexFrom = getIndex(from);
    long unsigned int indexTo = getIndex(to);
    _adjacencies[indexFrom][indexTo] = 0;
}

std::ostream &graph_t::print(std::ostream &out) const {
    for (long unsigned int k = 0; k < _nodes.size(); ++k) {
        auto idx = _handleMap.find(_nodes[k].getID());
        out << idx->second.name;
    }
    out << std::endl;
    for (long unsigned int i = 0; i < _adjacencies.size(); ++i) {
        out << "|";
        for (long unsigned int j = 0; j < _adjacencies.size(); ++j) {
            out << _adjacencies[i][j] << "|";
        }
        out << std::endl;
    }
    return out;
}

std::ostream &operator<<(std::ostream &os, const graph_t &graph) {
    graph.print(os);
    return os;
}

long unsigned int graph_t::getIndex(handle_t handle) const {
    for (long unsigned int i = 0; i < _nodes.size(); ++i) {
        if (_nodes[i].getID() == handle.getID()) return i;
    }
    return INVALID_HANDLE;
}

long unsigned int graph_t::getHandlesIndex(handle_t handle, std::vector<std::pair<handle_t, int>> handles) const {
    for (long unsigned int i = 0; i < handles.size(); ++i) {
        if (handles[i].first.getID() == handle.getID())
            return i;
    }
    return 0;
}

handle_t operator>>(vertex_t &vertex, graph_t &graph) {
    handle_t tHandle = graph.addVertex(vertex);
    return tHandle;
}

int graph_t::getShortestPath(handle_t const from, handle_t const to) const {
    std::vector<std::pair<handle_t, int>> unvisitedHandles;

    auto idxFrom = _handleMap.find(from.getID());
    if (idxFrom == _handleMap.end()) {
        std::cout << "Vertex from not found!" << std::endl;
        return INVALID_NODE;
    }

    auto idxTo = _handleMap.find(to.getID());
    if (idxTo == _handleMap.end()) {
        std::cout << "Vertex to not found!" << std::endl;
        return INVALID_NODE;
    }

    for (long unsigned int i = 0; i < _nodes.size(); ++i) {
        if (_nodes[i].getID() != from.getID())
            unvisitedHandles.push_back(std::make_pair(_nodes[i], NO_PATH));
    }
    unvisitedHandles.push_back(std::make_pair(_nodes[getIndex(from)], 0));

    while (!unvisitedHandles.empty()) {
        auto curItem = unvisitedHandles.back();
        unvisitedHandles.pop_back();

        if (curItem.first.getID() == to.getID())
            return ((curItem.second == NO_PATH) ? -1 : curItem.second);

        long unsigned int curIdx = getIndex(curItem.first);
        for (long unsigned int i = 0; i < _adjacencies.size(); ++i) {
            long unsigned int nextIdx = getHandlesIndex(_nodes[i], unvisitedHandles);
            if (nextIdx != INVALID_HANDLE) {
                int alt = curItem.second + _adjacencies[curIdx][i];
                if (alt != 0 && unvisitedHandles[nextIdx].second > alt) {
                    unvisitedHandles[nextIdx].second = alt;
                }
            }
        }
    }
    return NO_PATH;
}


