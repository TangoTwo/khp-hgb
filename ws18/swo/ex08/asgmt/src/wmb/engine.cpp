//
// Created by khp on 30.11.18.
//

#include <iostream>
#include <ctime>
#include <iomanip>
#include "engine.h"

engine::engine(unsigned int engineNum, std::string fuelType, unsigned int power, float consumption, time_t prodDate) {
    _engineNum = engineNum;
    _fuelType = fuelType;
    _power = power;
    _consumption = consumption;
    _prodDate = prodDate;
}

std::ostream &operator<<(std::ostream &os, const engine &engine) {
    if(engine._power == 0) { // NO POWER = NO ENGINE
        os << "No engine selected" << std::endl;
        return os;
    }
    os  << "Engine number = "   << engine._engineNum    << std::endl
        << "Fuel type = "       << engine._fuelType     << std::endl
        << "Power = "           << engine._power << " hp" << std::endl
        << "Consumption = "     << engine._consumption  << "l/100km" << std::endl
        << "Production date = " << std::put_time(std::localtime(&engine._prodDate), "%c %Z") << std::endl     << std::endl;
    return os;
}

std::istream &operator>>(std::istream &is, engine &engine) {
    is >> engine._engineNum >> engine._fuelType >> engine._power >> engine._consumption >> engine._prodDate;
    return is;
}
