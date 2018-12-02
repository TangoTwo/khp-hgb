//
// Created by khp on 30.11.18.
//

#include <iostream>
#include <sstream>
#include <vector>
#include <iterator>
#include "wheel.h"

#define DELIMITER ;

wheel::wheel(unsigned int diameter, unsigned short int prodYear, char speedIndex, std::string manufacturer) {
    _diameter = diameter;
    _prodYear = prodYear;
    _speedIndex = speedIndex;
    _manufacturer = manufacturer;
}

std::ostream &operator<<(std::ostream &os, const wheel &wheel) {
    os  << "Wheel diameter = "  << wheel._diameter      << std::endl
        << "Production year = " << wheel._prodYear      << std::endl
        << "Speed index = "     << wheel._speedIndex    << std::endl
        << "Manufacturer = "    << wheel._manufacturer  << std::endl;
    return os;
}

std::istream &operator>>(std::istream &is, wheel &wheel) {
    is >> wheel._diameter >> wheel._prodYear >> wheel._speedIndex >> wheel._manufacturer;
    return is;
}
