//
// Created by khp on 10.12.18.
//

#ifndef PROJECT_VECTOR_H
#define PROJECT_VECTOR_H

#include <cassert>

namespace swo {
    template<typename T>
    static void copy(T* dest, const T* src, size_t size) {
        assert(dest); assert(src);
        for (size_t i = 0; i < size; ++i) {
            dest[i] = src[i];
        }
    }

    template<typename T>
    class vector final {
        using SizeType = std::size_t;
        using ValueType = T;
        using Pointer = ValueType *;
        using Reference = ValueType &;
        using ConstReference = const ValueType &;

    public:
        vector() = delete;

        vector(SizeType capacity) : _capacity{capacity}, _data{new ValueType[_capacity]} {
        }

        vector(const vector &src) : _size{src._size}, _capacity{src._capacity}, _data{new ValueType[src._capacity]} {
            swo::copy(this->_data, src._data, size());
        }

        vector(const std::initializer_list<ValueType> &list) : _size{list.size()}, _capacity{list.size()}, _data{new ValueType[list.size()]} {
            swo::copy(this->_data, list.begin(), size());
        }

        void push_back(ValueType v) {
            assert(_size + 1 < _capacity);
            _data[_size++] = std::move(v);
        }

        SizeType size() const { return _size; };

        ConstReference operator[](SizeType idx) const {
            if (0 > idx || idx >= _size)
                throw std::range_error("index " + std::to_string(idx) + " out of range");
            return _data[idx];
        }

        Reference operator[](SizeType idx) {
            if (0 > idx || idx >= _size)
                throw std::range_error("index " + std::to_string(idx) + " out of range");
            return _data[idx];
        }
        friend std::ostream& operator<<(std::ostream &os, const vector<T> &v) {
            v.print(os);
            return os;
        }
    private:
        void print(std::ostream &os) const {
            os << "[";
            for (size_t i = 0; i < size(); ++i) {
                if (i>0) os << ",";
                os << _data[i];
            }
            os << "]" << std::flush;
        }
        SizeType _capacity{0};
        SizeType _size{0};
        Pointer _data{nullptr};
    };

}

#endif //PROJECT_VECTOR_H
