//
// Created by khp on 10.12.18.
//

#ifndef PROJECT_SIMPLEVECTOR_H
#define PROJECT_SIMPLEVECTOR_H

#include <stdexcept>
namespace swo {
    class sizeError : public std::exception {
    public:
        explicit sizeError(const std::string& msg) : std::exception(), _msg{msg} {
        }
        const char* what() const noexcept override {
            return _msg.c_str();
        }

    private:
        std::string _msg;
    };
    class simpleVector final{
        using SizeType = int;
        using ValueType = int;
        using Pointer = ValueType*;
        using Reference = ValueType&;
        using ConstReference = const ValueType&;
    public:
        simpleVector() = delete;
        simpleVector(SizeType size) : _size(size) {
            std::cout << "simpleVector(" << _size << ")" << std::endl;
            if (_size < 0) {
                throw sizeError("invalid size");
            }
            _data = new ValueType[size];
        }
        SizeType size() const {return _size;};

        ConstReference operator[](SizeType idx) const{
            if(0 > idx || idx >= _size)
                throw std::range_error("index " + std::to_string(idx) + " out of range");
            return _data[idx];
        }

        Reference operator[](SizeType idx) {
            if(0 > idx || idx >= _size)
                throw std::range_error("index " + std::to_string(idx) + " out of range");
            return _data[idx];
        }

        ~simpleVector() {
            std::cout << "~simpleVector(" << _size << ")" << std::endl;
            delete [] _data;
        }
    private:
        Pointer _data{nullptr};
        SizeType _size{0};
    };
}
#endif //PROJECT_SIMPLEVECTOR_H
