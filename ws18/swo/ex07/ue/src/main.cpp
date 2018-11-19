#include <iostream>
#include "rational.h"

int main() {
    swo3::rational r1{5,2};
    swo3::rational r2{1,2};
    swo3::rational r3{2,3};

    r1 += r2; // = r1.operator+=(r2);
    std::cout << "r1=" << r1 << std::endl; // operator<<(cout, r1);

    swo3::rational r4 = r2 + r3; // r4 = operator+(r2, r3);
    swo3::rational r5 = r2 + 1; // r5 = operator+(r2, rational(1));
    swo3::rational r6 = 1 + r2; // r6 = operator+(rational1, r2);
    std::cout << "r4 = " << r4 << std::endl;
    std::cout << "r5 = " << r5 << std::endl;
    std::cout << "r6 = " << r6 << std::endl;

    std::cout << "---END OF main---" << std::endl;
    return 0;
} // r3.~rational, r2.~rational, r1.~rational