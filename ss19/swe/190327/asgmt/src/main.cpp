#include <iostream>
#include "skipMap.h"


int main() {
    skip_map<int,int> m;
  std::pair<int, int> test3 = std::make_pair(15,10);
    std::pair<int, int> test = std::make_pair(10,10);
    std::pair<int, int> test2 = std::make_pair(12,10);
    m.insert(test);
    m.insert(test2);
    m.insert(test3);
    std::cout << m.find(10);
    //m.print();
    return 0;
}