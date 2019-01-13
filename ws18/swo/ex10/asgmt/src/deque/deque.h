//
// Created by khp on 05.01.19.
//

#ifndef SWO3_DEQUE_H
#define SWO3_DEQUE_H

#include <initializer_list>
#include <memory>
#include <iostream>

#define DEFAULT_SIZE 8
#define SIZE_MULTIPLIER 2

namespace swo3 {
    template<typename T>
    class deque final {
        using value_type = T;
        using reference = T &;
        using pointer = T *;
        using pointerArr = std::unique_ptr<T[]>;
        using size_type = size_t; // only replace with datatypes without negative values!

    class iterator final : public std::iterator<std::random_access_iterator_tag, T> {
            friend deque;
        public:
            using difference_type = int;

            iterator() = default;

            iterator(iterator const &other) : _pos{other._pos}, _first{other._first}, _last{other._last}{
            };

            iterator &operator=(iterator const &other){
                _pos = other._pos;
                _first = other._first;
                _last = other._last;
                return *this;
            };

            iterator &operator++() {
                if(_pos == _last)  // loop around
                    _pos = _first;
                else
                    _pos = (_pos + 1);
                return *this;
            }

            iterator operator++(int) {
                iterator tIt = *this;
                if(_pos == _last)  // loop around
                    _pos = _first;
                else
                    _pos = (_pos + 1);
                return tIt;
            }

            bool operator==(iterator const &other) {
                return _pos == other._pos;
            }

            bool operator!=(iterator const &other) {
                return _pos != other._pos;
            }

            reference operator*() {
                return *_pos;
            }

            iterator &operator--() {
                if(_pos == _first)  // loop around
                    _pos = _last;
                else
                    _pos = (_pos - 1);
                return this;
            }

            iterator operator--(int) {
                iterator tIt = *this;
                if(_pos == _first)  // loop around
                    _pos = _last;
                else
                    _pos = (_pos - 1);
                return &tIt;
            }

            iterator &operator+=(difference_type n) {
                _pos += n;
                return &this;
            }

            iterator operator+(difference_type n) {
                iterator tIt;
                tIt._pos = _pos + n;
                return tIt;
            }

            iterator operator+(iterator const &other) {
                iterator tIt;
                tIt._pos = _pos + other._pos;
                return tIt;
            }

            iterator &operator-=(difference_type n) {
                _pos -= n;
                return &this;
            }

            iterator operator-(difference_type n) {
                iterator tIt;
                tIt._pos = _pos - n;
                return tIt;
            }

            difference_type operator-(iterator const &other) {
                return _pos - other._pos;
            }

            reference operator[](difference_type n) {
                return &(_pos + n);
            }

            bool operator<(iterator const &other) {
                return _pos < other._pos;
            }

            bool operator>(iterator const &other) {
                return _pos > other._pos;
            }

            bool operator<=(iterator const &other) {
                return _pos <= other._pos;
            }

            bool operator>=(iterator const &other) {
                return _pos >= other._pos;
            }

        private:
            pointer _pos;
            pointer _first;
            pointer _last;
        };

    public:
        deque() {
            deque(DEFAULT_SIZE);
        }

        explicit deque(size_type count) : _size{count}, _data{std::make_unique<T[]>(count)} {

        }

        deque(size_type count, T const &value) : _size{count}, _data{std::make_unique<T[]>(count)} {
            for (size_type i = 0; i < _size; ++i) {
                _data[i] = value;
            }
        };

        deque(deque const &other) : _size{other._size}, _data{std::make_unique<T[]>(other._size)},
                                    _front{other._front}, _end{other._end} {
            std::copy(other._data, other._data + _size, _data);
        };

        deque(deque &&other) noexcept : _size{other._size}, _data{other._data},
                                        _front{other._front}, _end{other._end} {
            other._size = 0;
            other._data.reset();
        };

        deque(std::initializer_list<T> init) {
            _size = init.size();
            _front = 0;
            _end = 0;
            _data = std::make_unique<T[]>(_size);
            for (size_type i = 0; i < _size; ++i) {
                _data[i] = *(init.begin() + i);
            }
        };

        ~deque() {
            _data.reset();
        };

        deque &operator=(deque const &other) {
            _front = other._front;
            _end = other._end;
            _size = other._size;
            _data = std::make_unique<T[]>(_size);
            std::copy(other._data, other._data + _size, _data);
            return *this;
        };

        deque &operator=(deque &&other) noexcept {
            _front = other._front;
            _end = other._end;
            _size = other._size;
            _data = other._data;
            other._size = 0;
            other._data.reset();
            return *this;
        };

        deque &operator=(std::initializer_list<T> init) {
            _size = init.size();
            _front = _size - 1;
            _end = 0;
            _data = std::make_unique<T[]>(_size);
            for (size_type i = 0; i < _size; ++i) {
                _data[i] = init[i];
            }
            return *this;
        }

        reference operator[](size_type pos) {
            return at(pos);
        }

        reference at(size_type pos) {
            if (pos > _end || pos < _front) {
                std::cerr << "Wrong index!" << std::endl;
                return nullptr;
            }
            return &_data[pos];
        }

        reference back() {
            if ((_end - 1) % _size == _front) {
                std::cerr << "Nothing to pop!" << std::endl;
                return nullptr;
            }
            return &_data[_end];
        }

        reference front() {
            if ((_front + 1) % _size == _end) {
                std::cerr << "Nothing to pop!" << std::endl;
                return nullptr;
            }
            return &_data[_front];
        }

        iterator begin() noexcept {
            iterator tIt;
            tIt._pos = &_data[_front];
            tIt._first = &_data[0];
            tIt._last = &_data[_size-1];
            return tIt;
        }

        iterator end() noexcept {
            iterator tIt;
            tIt._pos = &_data[_end];
            tIt._first = &_data[0];
            tIt._last = &_data[_size-1];
            return tIt;
        }

        bool empty() const noexcept {
            return _size != 0;
        }

        size_type size() const noexcept {
            return _size;
        }

        void clear() noexcept {
            _size = 0;
            _front = 0;
            _end = 0;
            _data.reset();
        }

        void push_back(T const &value) {
            if ((_end + 1) % _size == _front) {
                resize(SIZE_MULTIPLIER * _size);
            }
            _data[_end] = value;
            _end = (_end + 1) % _size; // loop around
        }

        void push_back(T &&value) {
            if ((_end + 1) % _size == _front) {
                resize(SIZE_MULTIPLIER * _size);
            }
            _data[_end] = std::move(value);
            _end = (_end + 1) % _size; // loop around
        }

        void pop_back() {
            if ((_end - 1) % _size == _front) {
                std::cerr << "Nothing to pop!" << std::endl;
                return;
            }
            _end = (_end - 1) % _size; // loop around
        }

        void push_front(T const &value) {
            if(_front == 0)// loop around
                _front = _size-1;
            else
                _front = (_front - 1) % _size;
            if (_end == _front) {
                resize(SIZE_MULTIPLIER * _size);
            }
            _data[_front] = value;
        }

        void push_front(T &&value) {
            if(_front == 0)// loop around
                _front = _size-1;
            else
                _front = (_front - 1) % _size;
            if (_end == _front) {
                resize(SIZE_MULTIPLIER * _size);
            }
            _data[_front] = std::move(value);
        }

        void pop_front() {
            if ((_front + 1) % _size == _end) {
                std::cerr << "Nothing to pop!" << std::endl;
                return;
            }
            _front = (_front + 1) % _size; // loop around
        }

        void resize(size_type count) {
            pointerArr tData = std::make_unique<T[]>(count);
            std::copy(&_data[0], &_data[_end], tData.get());
            std::copy(&_data[_front], &_data[_size], tData.get()+ count - (_size - _front));
            _front = count - (_size - _front);
            _size = count;
            _data = std::move(tData);
        }

        void swap(deque &other) noexcept {
            if (other._size != this->_size) {
                std::cerr << "Can't swap two different length deques" << std::endl;
                return;
            }
            pointer tData;
            tData = std::move(other._data);
            other._data = std::move(_data);
            _data = std::move(tData);
        }

    private:
        size_type _size{0};
        pointerArr _data{nullptr};
        size_type _front{0};
        size_type _end{0};
    };

    template<typename T>
    bool operator==(deque<T> const &lhs, deque<T> const &rhs) {
        return lhs.size() == rhs.size();
    }

    template<typename T>
    bool operator!=(deque<T> const &lhs, deque<T> const &rhs) {
        return lhs.size() != rhs.size();
    }

    template<typename T>
    bool operator<(deque<T> const &lhs, deque<T> const &rhs) {
        return lhs.size() < rhs.size();
    }

    template<typename T>
    bool operator<=(deque<T> const &lhs, deque<T> const &rhs) {
        return lhs.size() <= rhs.size();
    }

    template<typename T>
    bool operator>(deque<T> const &lhs, deque<T> const &rhs) {
        return lhs.size() > rhs.size();
    }

    template<typename T>
    bool operator>=(deque<T> const &lhs, deque<T> const &rhs) {
        return lhs.size() >= rhs.size();
    }

}


#endif //SWO3_DEQUE_H
