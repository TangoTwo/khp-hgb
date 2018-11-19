//
// Created by khp on 19.11.18.
//
#include <iostream>
#include "rational.h"

namespace swo3 {

    constexpr int gcd(int a, int b) {
        int r = 0;
        do {
            r = a % b;
            a = b;
            b = r;
        }while( r > 0);
        return a;
    }

    rational::rational() : rational(0, 1) {
        std::cout << "rational::rational()" << std::endl;
    }

    rational::rational(int num) : rational(num, 1) {
        std::cout << "rational::rational(" << num << ")" << std::endl;
    }

    rational::rational(int num, int den) : _num{num}, _den{den} {
        std::cout << "rational::rational(" << num << "," << den << ")" << std::endl;
        reduce();
    }

    rational::~rational() {
        std::cout << "rational::~rational(" << _num << "," << _den << ")" << std::endl;
    }

    rational &rational::operator+=(const rational &r) {
        this->_num = (this->_num * r._den + this->_den * r._num);
        this->_den = (this->_den * r._den);
        reduce();
        return *this;
    }

    void rational::print(std::ostream &os) const{
        os << _num << "/" << _den << std::flush;
    }

    void rational::reduce() {
        int g = gcd(_num, _den);
        if(g!= 0) {
            _num /= g;
            _den /= g;
        }
    }

    rational operator+(const rational &r1, const rational &r2) {
        rational sum{r1};
        sum += r2;
        return sum;
    }

    std::ostream &operator<<(std::ostream &os, const rational &r){
        os << r._num << "/" << r._den << std::flush;
        return os;
    }
}