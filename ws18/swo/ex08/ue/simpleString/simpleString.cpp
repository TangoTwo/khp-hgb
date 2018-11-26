//
// Created by khp on 26.11.18.
//
#include <cstring>
#include <iostream>
#include <cassert>
#include "simpleString.h"

namespace swo {
    simpleString::simpleString() /*: _mData{nullptr}, _mSize{0} OPTIONAL*/{
        std::cout << __func__ << "()" << std::endl;
    }

    simpleString::simpleString(const_pointer c_str) {
        std::cout << __func__ << "(" << c_str << ")" << std::endl;
        this->_mSize = std::strlen(c_str);
        this->_mData = this->_mSize == 0 ? nullptr : new value_type[this->_mSize + 1];
        std::strcpy(this->_mData, c_str);
    }

    simpleString::~simpleString() {
        std::cout << __func__ << "(" << (this->_mData ? this->_mData : "") << ")" << std::endl;
        delete[] _mData;
        _mData = nullptr;
    }

    simpleString::simpleString(const simpleString &other) {
        std::cout << __func__ << "(" << other._mData << ")" << std::endl;
        copyFrom(other);
    }

    void simpleString::copyFrom(const simpleString &other) {
        std::cout << __func__ << "(" << other._mData << ") (COPY)" << std::endl;
        if(other.isEmpty()) {
            this->_mData = nullptr;
        }
        else {
            this->_mData = new value_type[other._mSize + 1];
            std::strcpy(this->_mData, other._mData);
        }
        this->_mSize = other._mSize;
    }

    std::ostream &operator<<(std::ostream &os, const simpleString &s) {
        if(!s.isEmpty()) os << s._mData;
        return os;
    }

    simpleString &simpleString::operator+=(const simpleString &other) {
        std::cout << __func__ << "(" << other._mData << ") (COPY)" << std::endl;
        if (!other.isEmpty()) {
            pointer oldData = this->_mData;
            std::size_t oldSize = this->_mSize;

            this->_mSize += other._mSize;
            this->_mData = new value_type[this->_mSize + 1];
            std::strcpy(this->_mData, oldData);
            std::strcpy(this->_mData + oldSize, other._mData);
            delete[] oldData;
        }
        return *this;
    }

    simpleString &simpleString::operator=(const simpleString &other) {
        std::cout << __func__ << "(" << other._mData << ") (COPY)" << std::endl;

        if(this != &other) {
            delete[] this->_mData;
            std::strcpy(this->_mData, other._mData);
        }
        return *this;
    }

    simpleString::value_type simpleString::operator[](std::size_t index) const {
        assert(this->_mData);
        assert(index < this->_mSize);
        return this->_mData[index];
    }

    simpleString::value_type &simpleString::operator[](std::size_t index) {
        assert(this->_mData);
        assert(index < this->_mSize);

        return this->_mData[index];
    }
}