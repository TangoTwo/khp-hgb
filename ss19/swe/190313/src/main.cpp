//
// Created by khp on 13.03.19.
//

#include <map>
#include <set>
#include <vector>
#include <iterator>
#include <algorithm>
#include <string>
#include <cassert>
#include <sstream>
#include <iomanip>
#include <iostream>
#include <chrono>
#include <random>

template<typename Func>
auto timed(Func func) -> std::chrono::microseconds {
    const auto start{std::chrono::high_resolution_clock::now()};
    func();
    const auto stop{std::chrono::high_resolution_clock::now()};
    return std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);
}

const auto max{12};

void vector_demo() {
    std::vector<int> vec;
    vec.reserve(max);
    for (int i = 0; i < max; ++i) {
        vec.push_back(static_cast<int &&>(random()));
    }
    for (const auto &val : vec) {
        std::cout << val << ' ';
    }
    std::cout << " contained: ";
    for (int j = 0; j < max; ++j) {
        if (const auto it{std::find(std::begin(vec), std::end(vec), j)}; it != std::end(vec)) //O(n)
            std::cout << j << ' ';
    }
    std::cout << std::endl;
}

void set_demo() {
    std::set<int> set;
    for (int i = 0; i < max; ++i) {
        set.insert(static_cast<int &&>(random())); //O(log n)
    }
    for (const auto &val : set) {
        std::cout << val << ' ';
    }
    std::cout << " contained: ";
    for (int j = 0; j < max; ++j) {
        if(set.find(j) != std::end(set)) //O(log n)
            std::cout << j << ' ';
    }
    std::cout << std::endl;
}

void map_demo() {
    std::map<int, int> map;
    for (int i = 0; i < max; ++i) {
        const auto tmp{rand()};
        map.insert(std::make_pair(tmp, tmp*20)); //O(log n)
    }
    for (const auto &val : map) {
        std::cout << val.second << ' ';
    }
    std::cout << " contained: ";
    for (const auto &val : map) {
        if(const auto it{map.find(val.first)}; it != std::end(map))
        std::cout << it->second << ' ';
    }
    std::cout << std::endl;
}

template <typename Container>
auto time_insert(int count) -> std::chrono::milliseconds {
    Container cont;

    return timed([&] {
        for(auto i = 0; i < count ; i++) {
            const auto tmp{rand()};
            cont.insert(std::lower_bound(std::begin(cont), std::end(cont), tmp), tmp);
        }
    });
}
int main() {
    std::cout << timed(set_demo).count();
    std:: cout << timed(vector_demo).count();

    std::cout << "VECTOR: " << time_insert<std::vector}