//
// Created by khp on 01.12.18.
//

#include "vertexT.h"

std::ostream &operator<<(std::ostream &os, const vertex_t &vertex) {
    os << vertex.name;
    return os;
}

std::istream &operator>>(std::istream &is, vertex_t &vertex) {
    is >> vertex.name;
    return is;
}
