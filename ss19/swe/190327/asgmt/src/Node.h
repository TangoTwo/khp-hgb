//
// Created by Jakob Stadlhuber on 2019-03-31.
//

#ifndef PROJECT_NODE_H
#define PROJECT_NODE_H

#include <cstddef>
#include <utility>
#include <memory>
#include <vector>
#include "Types.h"

template<typename Key, typename Type>
class Node {
public:
    using key_type = Key;
    using mapped_type = Type;
    using value_type = std::pair<const Key, Type>;
    using size_type = std::size_t;
    using node_type = Node<Key, Type>;

    Node(value_type value, const size_type maxLevel) : _value{value}, _MAXLEVEL{maxLevel} {
      for (int i = 0; i < maxLevel; ++i) {
        _levels.push_back(nullptr);
      }
    };

    std::shared_ptr<node_type> next(int level) {
        return _levels.at(level);
    }

    void connect(unsigned int level, std::shared_ptr<node_type> nextNode) {
        _levels.at(level) = nextNode;
    }

    value_type getValue() const {
        return _value;
    }
  std::vector<std::shared_ptr<node_type>> getLevels() const { return _levels; };
    std::vector<std::shared_ptr<node_type>>& getLevels() { return _levels; };

private:
  value_type _value;
  const size_type _MAXLEVEL;
  std::vector<std::shared_ptr<node_type>> _levels;
};
#endif //PROJECT_NODE_H
