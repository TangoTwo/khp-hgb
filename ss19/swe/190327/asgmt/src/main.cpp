#include <iostream>
#include "skipMap.h"

int main() {
  // TEST 1 - PAARE EINFÜGEN
  std::cout << "Test 1" << std::endl;
  skip_map<int, int> m;
  std::pair<int, int> test3 = std::make_pair(15, 10);
  std::pair<int, int> test2 = std::make_pair(12, 10);
  m.insert(test2);
  m.insert(test3);
  std::cout << "Test 1 - SUCCESS" << std::endl;

  // TEST 2 - 100'000 bis 0 einfügen
  std::cout << "Test 2" << std::endl;
  skip_map<int, int> m2;
  for(int i = 100000; i > 0; i--){
    if(m2.insert(std::make_pair(i, 9999)).second == false)
      std::cout << "FAILED TO INSERT!" << std::endl;
  }

  // TEST 3 - 0 bis 100'000 einfügen
  std::cout << "Test 3" << std::endl;
  skip_map<int, int> m3;
  for(int i = 0; i < 100000; i++){
    if(m3.insert(std::make_pair(i, 9999)).second == false)
      std::cout << "FAILED TO INSERT!" << std::endl;
  }

  // TEST 4 - Eintrag finden, existierend oder nicht
  std::cout << "Test 4" << std::endl;
  skip_map<int, int> m4;
  m4.insert(std::make_pair(10, 9999));
  std::cout << (m4.find(10) != m4.end()) << " <-- should be true(1)." << std::endl;
  std::cout << (m4.find(12) != m4.end()) << " <-- should be false(0)." << std::endl;
  std::cout << "Test 4 - SUCCESS" << std::endl;
  return 0;
}