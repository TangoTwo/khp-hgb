//
// Created by khp on 14.01.19.
//

#ifndef PROJECT_LISTITER_H
#define PROJECT_LISTITER_H

#include <ml5/container/iterator.h>
#include "list_node.h"

template <typename T>
class list_iter : ml5::iterator<T> {
public:
    explicit list_iter(list_node<T>* head);

    T& get_current() const override;
    bool is_at_end() const noexcept override;
    void to_next();

private:
    list_node<T>* _current;
};

#include "listIter.inl"
#endif //PROJECT_LISTITER_H
