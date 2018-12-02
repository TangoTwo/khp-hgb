//
// Created by khp on 30.11.18.
//

#include <iostream>
#include <iomanip>
#include "car.h"
#include "wheel.h"

car::car(std::string type, std::string colour, int serialNr, time_t prodDate, std::string prodLoc,
         std::string transmission, std::string drivingMode, int maxVelocity, int weight) {
    _type = type;
    _colour = colour;
    _serialNr = serialNr;
    _prodDate = prodDate;
    _prodLoc = prodLoc;
    _transmission = transmission;
    _drivingMode = drivingMode;
    _maxVelocity = maxVelocity;
    _weight = weight;
}

void car::addEngine(engine engine) {
    _engine = engine;
}

void car::addWheel(wheel wheel) {
    _wheel = wheel;
}

std::ostream &operator<<(std::ostream &os, const car &car) {
    os << "Car type = " << car._type << std::endl
       << "Colour = " << car._colour << std::endl
       << "Serial number = " << car._serialNr << std::endl
       << "Production date = " << std::put_time(std::localtime(&car._prodDate), "%c %Z") << std::endl
       << "Production location = " << car._prodLoc << std::endl
       << "Transmission type = " << car._transmission << std::endl
       << "Driving mode = " << car._drivingMode << std::endl
       << "Maximum speed = " << car._maxVelocity << " kph" << std::endl
       << "Weight = " << car._weight << " kg" << std::endl;
    os << car._engine << std::endl;
    os << car._wheel << std::endl;
    return os;
}

std::istream &operator>>(std::istream &is, car &car) {
    is >> car._type >> car._colour >> car._serialNr >> car._prodDate >> car._prodLoc >> car._transmission >> car._drivingMode >> car._maxVelocity >> car._weight;
    return is;
}

void operator>>(wheel &wheel, car &car) {
    car.addWheel(wheel);
}

void operator>>(engine &engine, car &car) {
    car.addEngine(engine);
}

