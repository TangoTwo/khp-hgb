//
// Created by khp on 01.12.18.
//

#ifndef SWO_VERTEXT_H
#define SWO_VERTEXT_H


#include <string>

class vertex_t {
    friend std::ostream &operator<<(std::ostream &os, const vertex_t &vertex);
    friend std::istream &operator>>(std::istream &is, vertex_t &vertex);

public:
    std::string name{""};

};
std::ostream &operator<<(std::ostream &os, const vertex_t &vertex);
std::istream &operator>>(std::istream &is, vertex_t &vertex);

#endif //SWO_VERTEXT_H
