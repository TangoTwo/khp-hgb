//
// Created by khp on 31.03.19.
//

#ifndef SWE4_SKIPMAP_H
#define SWE4_SKIPMAP_H
#include <vector>
#include <iostream>
#include <memory>
#include <random>
#include "Node.h"

using std::cout;
using std::endl;

template<typename Key, typename Type, std::size_t MAXLEVEL=32>
class skip_map{
 public:
  using key_type=Key;
  using mapped_type=Type;
  using value_type=std::pair<const Key, Type>;
  using size_type   = std::size_t;
  using node_type = Node<Key, Type>;

  skip_map(){};
  ~skip_map(){};

  size_type size() const;
  bool find(const key_type &key) const {
    if(initNode.getLevels().at(0) == nullptr) {
      return false;
    }
    std::shared_ptr<node_type> currentLevel = std::make_shared<node_type >(initNode);
    for (int i = MAXLEVEL-1; i >= 0; --i) {
      while (currentLevel && currentLevel->getLevels().at(i) != NULL && currentLevel->getLevels().at(i)->getValue().first < key) {
        currentLevel = currentLevel->getLevels().at(i);
      }
    }
    currentLevel = currentLevel->getLevels().at(0);
    return !(!currentLevel || currentLevel->getValue().first != key);
  }
  bool insert(const value_type &entry) {
    std::vector<node_type*> tProjection;
    for (int j = 0; j < MAXLEVEL; ++j) {
      tProjection.push_back(&initNode);
    }
    std::shared_ptr<node_type> currentLevel = std::make_shared<node_type >(initNode);
    for (int i = MAXLEVEL-1; i >= 0; --i) {
      while (currentLevel && currentLevel->getLevels().at(i) != NULL && currentLevel->getLevels().at(i)->getValue().first < entry.first) {
        currentLevel = currentLevel->getLevels().at(i);
      }
      tProjection.at(i)->getLevels().at(i) = currentLevel;
    }
    if(currentLevel->getValue().first == entry.first) {
      return false;
    } else {
      unsigned int randLvl = 4; //TOTALLY RANDOM
      std::shared_ptr<node_type> newNode = std::make_shared<node_type>(entry, randLvl);
      for (int i = 0; i < randLvl; ++i) {
        newNode->connect(i, tProjection.at(i)->getLevels().at(i)->getLevels().at(i));
        tProjection.at(i)->getLevels().at(i)->connect(i, newNode);
      }
    }
  }

 private:
  node_type initNode{node_type(value_type (Key{0}, Type{}), MAXLEVEL)};
};
#endif //SWE4_SKIPMAP_H
