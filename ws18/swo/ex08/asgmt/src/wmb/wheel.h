//
// Created by khp on 30.11.18.
//

#ifndef SRC_WHEEL_H
#define SRC_WHEEL_H


#include <string>

class wheel {
    friend std::ostream &operator<<(std::ostream&, const wheel&);
    friend std::istream &operator>>(std::istream&, wheel&);
public:
    wheel() = default;
    wheel(unsigned int diameter, unsigned short int prodYear, char speedIndex, std::string manufacturer);

private:
    unsigned int _diameter{0};
    unsigned short int _prodYear{0};
    char _speedIndex{};
    std::string _manufacturer{""};
};
std::ostream &operator<<(std::ostream&, const wheel&);
std::istream &operator>>(std::istream&, wheel&);


#endif //SRC_WHEEL_H
