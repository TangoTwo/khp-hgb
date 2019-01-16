template <typename T>
void list<T>::add(T value) {
    list_node<T>* new_node = new list_node<T>(value);
    if(_tail) {
        _tail->_next = new_node;
        _tail = new_node;
    } else {
        _tail = _head = new_node;
    }
    _size++;
}

template<typename T>
std::unique_ptr<ml5::iterator<T>> list<T>::make_iterator() const {
    return std::make_unique<list_iter<T>>(_head);
}

template<typename T>
void list<T>::remove(const T &value) noexcept {
    if(!this->contains(value))
        return;

    list_node<T> *curr = _head;
    list_node<T> *prev = nullptr;

    while (curr != nullptr) {
        if(curr->_value == value) {
            if(!prev) {
                _head = curr->_next;
            } else if(curr == _tail) {
                prev->_next = nullptr;
                _tail = prev;
            }
        }
    }
}

template<typename T>
bool list<T>::contains(const T &value) const noexcept {
    for(list_node<T>* n = _head; n != nullptr; n = n->_next) {
        if (n->_value == value)
            return true;
    }
    return false;
}

template<typename T>
std::size_t list<T>::size() const noexcept {
    return _size;
}

template <typename T>
void list<T>::clear() noexcept {
    list_node<T>* n = _head;
    while(n != nullptr){
        list_node<T>* next = n->_next;
        delete n;
        n = next;
    }
}

template<typename T>
list<T>::~list() {
    clear();
}
