//
// Created by khp on 14.01.19.
//

#ifndef PROJECT_LIST_NODE_H
#define PROJECT_LIST_NODE_H

template<typename T>
class list_node : public ml5::object {
    template<typename> friend
    class list;

    template<typename> friend
    class list_iter;

    explicit list_node(T value) : _value{std::move(value)} {

    }

    list_node *_next{nullptr};
    T _value{};
};

#endif //PROJECT_LIST_NODE_H
