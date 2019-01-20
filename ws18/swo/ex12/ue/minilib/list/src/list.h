//
// Created by khp on 14.01.19.
//

#ifndef PROJECT_LIST_H
#define PROJECT_LIST_H

#include <ml5/ml5.h>
#include "list_node.h"

template <typename T>
class list : public ml5::container<T> {
public:
    ~list();
    void add(T value);
    void clear() noexcept;
    bool contains(T const& value) const noexcept;
    std::unique_ptr<ml5::iterator<T>> make_iterator() const;
    void remove(T const& value) noexcept;
    std::size_t size() const noexcept;

private:
    list_node<T>* _head{nullptr};
    list_node<T>* _tail{nullptr};
    std::size_t _size{0};
};

#include "list.inl"
#endif //PROJECT_LIST_H
