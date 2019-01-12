//
// Created by khp on 05.01.19.
//

#include "deque.h"

int main() {
    swo3::deque<char> deque1{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'};
    deque1.pop_back();
    deque1.pop_front();
    for (const auto &item : deque1) {
        std::cout << item;
    }
    std::cout << deque1.size();
    return EXIT_SUCCESS;
}