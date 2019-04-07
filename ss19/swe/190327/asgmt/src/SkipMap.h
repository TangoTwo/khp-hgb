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
  class skip_map_iterator{
   public:
    skip_map_iterator() = default;
    skip_map_iterator(skip_map* v) : _curNode{v->initNode} {};
    skip_map_iterator(Node<Key, Type>* v) : _curNode{v} {};
    bool operator==(const skip_map_iterator& rhs) const {
      return _curNode == rhs._curNode;
    }
    bool operator!=(const skip_map_iterator& rhs) const {
      return _curNode != rhs._curNode;
    }
    skip_map_iterator operator++(int) {
      auto tNode = _curNode;
      _curNode = _curNode->next(0);
      return tNode;
    };
    skip_map_iterator& operator++() {
      _curNode = _curNode->next(0);
      return *this;
    };
    Node<Key, Type>& operator*() const {
      return *_curNode;
    }
    Node<Key, Type>* operator->() const {
      return _curNode;
    }
   private:
    Node<Key, Type>* _curNode;
  };
 public:
  using iterator=skip_map_iterator;
  using key_type=Key;
  using mapped_type=Type;
  using value_type=std::pair<const Key, Type>;
  using size_type   = std::size_t;
  using node_type = Node<Key, Type>;

  skip_map(){};
  ~skip_map(){};

  size_type size() const {
    auto tNode = _initNode;
    unsigned int size = 0;
    while(_initNode) {
      size++;
      _initNode = _initNode.next(0);
    }
    return size;
  }

  iterator find(const key_type &key) const {
    if(_initNode.getLevels().at(0) == nullptr) {
      return skip_map_iterator();
    }
    std::shared_ptr<node_type> currentLevel = std::make_shared<node_type >(_initNode);
    for (int i = MAXLEVEL-1; i >= 0; --i) {
      while (currentLevel && currentLevel->getLevels().at(i) != NULL && currentLevel->getLevels().at(i)->getValue().first < key) {
        currentLevel = currentLevel->getLevels().at(i);
      }
    }
    currentLevel = currentLevel->getLevels().at(0);
    if (!currentLevel || currentLevel->getValue().first != key) {
      return skip_map_iterator();
    } else {
      return skip_map_iterator(currentLevel.get());
    }
  }
  std::pair<iterator, bool> insert(const value_type &entry) {
    std::vector<node_type*> tProjection;
    for (int j = 0; j < MAXLEVEL; ++j) {
      tProjection.push_back(&_initNode);
    }
    std::shared_ptr<node_type> currentLevel = std::make_shared<node_type >(_initNode);
    for (int i = MAXLEVEL-1; i >= 0; --i) {
      while (currentLevel && currentLevel->getLevels().at(i) != NULL && currentLevel->getLevels().at(i)->getValue().first < entry.first) {
        currentLevel = currentLevel->getLevels().at(i);
      }
      tProjection.at(i)->getLevels().at(i) = currentLevel;
    }
    if(currentLevel->getValue().first == entry.first) {
      return std::make_pair<iterator, bool>(skip_map_iterator(currentLevel.get()), false);
    } else {
      std::random_device rd;
      std::uniform_int_distribution<int> dist(1, MAXLEVEL-1);
      int randLvl = dist(rd);
      std::shared_ptr<node_type> newNode = std::make_shared<node_type>(entry, randLvl);
      for (int i = 0; i < randLvl; ++i) {
        newNode->connect(i, tProjection.at(i)->getLevels().at(i)->getLevels().at(i));
        tProjection.at(i)->getLevels().at(i)->connect(i, newNode);
      }
      return std::make_pair<iterator, bool>(skip_map_iterator(newNode.get()), true);
    }
  }
  iterator begin()const {
    return skip_map_iterator(_initNode);
  }
  iterator end()const {
    return skip_map::iterator();
  }

  mapped_type &operator[](const key_type &key){
    auto test = insert(value_type(key, mapped_type{}));
    auto test2 = test.first;
    auto test3 = test2.operator*().getValue().first;
    return test3;
  }
 private:
  node_type _initNode{node_type(value_type (Key{0}, Type{}), MAXLEVEL)};
};
#endif //SWE4_SKIPMAP_H
