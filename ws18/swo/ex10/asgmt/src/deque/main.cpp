//
// Created by khp on 05.01.19.
//

#include "deque.h"

int main() {
    swo3::deque<int> deque1(3);
    deque1.push_back(1);
    deque1.push_back(3);
    deque1.push_front(5);
    deque1.push_front(6);
    deque1.push_front(7);
    deque1.push_front(8);
    deque1.pop_back();
    deque1.pop_back();
    deque1.pop_back();
    deque1.pop_back();
    deque1.pop_back();
    for(auto it = deque1.begin(); it != deque1.end(); it++)
        std::cout << *it << ",";

    std::cout << std::endl << deque1.size();
    return EXIT_SUCCESS;
}