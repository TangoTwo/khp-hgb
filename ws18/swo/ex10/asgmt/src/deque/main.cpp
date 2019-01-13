//
// Created by khp on 05.01.19.
//
#include <iostream>
#include "deque.h"

void test_constructor() {
    std::cout << "### TEST CONSTRUCTION ###" << std::endl;
    swo3::deque<char> deque1;
    swo3::deque<int> deque2(8);
    swo3::deque<int> deque3(4, 0);
}

void test_pushPop() {
    std::cout << "### TEST PUSH_POP ###" << std::endl;
    swo3::deque<int> deque2(8);

    deque2.push_back(2);
    deque2.push_back(3);
    deque2.push_back(4);
    deque2.push_front(2);

    std::cout << deque2.size() << " <-- should be 4" << std::endl;
}

void test_assign() {
    std::cout << "### TEST ASSIGN ###" << std::endl;
    swo3::deque<int> deque1(4);
    swo3::deque<int> deque2;

    deque2 = deque1;
}

void test_at() {
    std::cout << "### TEST AT METHOD ###" << std::endl;
    swo3::deque<int> deque1(4);

    deque1.push_back(2);
    deque1.push_back(3);
    deque1.push_back(4);
    deque1.push_front(2);

    std::cout << deque1.at(0) << " <-- should be 2" << std::endl;
    try {
        std::cout << deque1.at(99) << " <-- should throw an error" << std::endl;
    } catch (std::out_of_range &err) {
        std::cout << err.what() << std::endl;
    }
}

void test_index() {
    std::cout << "### TEST INDEX ###" << std::endl;
    swo3::deque<int> deque1(4);

    deque1.push_back(7);
    deque1.push_back(3);
    deque1.push_back(4);
    deque1.push_front(2);

    std::cout << deque1.at(1) << " <-- should be 3" << std::endl;
}

void test_pushPopResize() {
    std::cout << "### TEST PUSH_POP WITH RESIZE ###" << std::endl;
    swo3::deque<int> deque2(3);

    deque2.push_back(2);
    deque2.push_back(3);
    deque2.push_back(4);
    deque2.push_front(2);
    deque2.push_front(2);
    deque2.push_front(2);

    std::cout << deque2.size() << " <-- should be 6" << std::endl;
}

void test_iter_auto() {
    std::cout << "### TEST ITERATOR AUTO ###" << std::endl;
    swo3::deque<int> deque2(8);

    deque2.push_back(2);
    deque2.push_back(3);
    deque2.push_back(4);

    deque2.push_front(6);
    deque2.push_front(22);
    deque2.push_front(3);

    for (const auto &item : deque2) {
        std::cout << item << std::endl;
    }
}

void test_iter() {
    std::cout << "### TEST ITERATOR ###" << std::endl;
    swo3::deque<int> deque2(8);

    deque2.push_back(2);
    deque2.push_back(3);
    deque2.push_back(4);

    deque2.push_front(6);
    deque2.push_front(22);
    deque2.push_front(3);

    for (auto item = deque2.begin(); item != deque2.end(); ++item) {
        std::cout << *item << std::endl;
    }
}

void test_frontBack() {
    std::cout << "### TEST FRONT-BACK ###" << std::endl;
    swo3::deque<int> deque1(8);

    deque1.push_back(2);
    deque1.push_back(3);
    deque1.push_back(4);

    std::cout << deque1.front() << " <-- should be 2" << std::endl;
    std::cout << deque1.back() << " <-- should be 4" << std::endl;
}

void test_swap() {
    std::cout << "### TEST SWAP ###" << std::endl;
    swo3::deque<int> deque1(8);

    deque1.push_back(2);
    deque1.push_back(3);
    deque1.push_back(4);

    swo3::deque<int> deque2(8);

    deque2.push_front(6);
    deque2.push_front(22);
    deque2.push_front(3);

    std::cout << "## BEFORE SWAP ##" << std::endl;
    std::cout << "# DEQUE1 #" << std::endl;
    for (const auto &item : deque1) {
        std::cout << item << std::endl;
    }
    std::cout << "# DEQUE2 #" << std::endl;
    for (const auto &item2 : deque2) {
        std::cout << item2 << std::endl;
    }

    deque1.swap(deque2);

    std::cout << "## AFTER SWAP ##" << std::endl;
    std::cout << "# DEQUE1 #" << std::endl;
    for (const auto &item : deque1) {
        std::cout << item << std::endl;
    }
    std::cout << "# DEQUE2 #" << std::endl;
    for (const auto &item2 : deque2) {
        std::cout << item2 << std::endl;
    }
}

int main() {
    test_constructor();
    test_assign();
    test_at();
    test_index();
    test_frontBack();
    test_pushPop();
    test_pushPopResize();
    test_iter();
    test_iter_auto();
    test_swap();

    return EXIT_SUCCESS;
}