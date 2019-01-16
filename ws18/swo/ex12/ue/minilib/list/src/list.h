//
// Created by khp on 14.01.19.
//

#ifndef PROJECT_LIST_H
#define PROJECT_LIST_H

#include <ml5/ml5.h>
#include "list_node.h"
#include "listIter.h"

template <typename T>
class list : public ml5::container<T> {
    template <typename> friend class list_iter;
public:
    ~list();
    void add(T value) override;
    void clear() noexcept override;
    bool contains(T const& value) const noexcept override;
    std::unique_ptr<ml5::iterator<T>> make_iterator() const override;
    void remove(T const& value) noexcept override;
    std::size_t size() const noexcept override;

private:
    list_node<T>* _head{nullptr};
    list_node<T>* _tail{nullptr};
    std::size_t _size{0};
};

#include "list.inl"
#endif //PROJECT_LIST_H
