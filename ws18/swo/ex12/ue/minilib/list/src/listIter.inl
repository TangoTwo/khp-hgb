template<typename T>
T &list_iter<T>::get_current() const {
    if(is_at_end())
        throw std::out_of_range("list_iter<T>::get_current(): cannot dereference end iterator");
    return _current->_value;
}

template<typename T>
bool list_iter<T>::is_at_end() const noexcept {
    return !_current;
}

template<typename T>
void list_iter<T>::to_next() {
    if(is_at_end())
        throw std::out_of_range("list_iter<T>::to_next(): cannot dereference end iterator");
    _current = _current->_next;
}

template<typename T>
list_iter<T>::list_iter(list_node<T> *head) : _current{head}{
}
