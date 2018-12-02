//
// Created by khp on 30.11.18.
//

#ifndef SRC_CAR_H
#define SRC_CAR_H

#include <string>
#include <vector>
#include "wheel.h"
#include "engine.h"

class car {
    friend std::ostream &operator<<(std::ostream &, const car &);
    friend std::istream &operator>>(std::istream&, car&);
    friend void operator>>(wheel&, car&);
    friend void operator>>(engine&, car&);

public:
    car() = default;
    car(std::string type, std::string colour, int serialNr, time_t prodDate, std::string prodLoc,
             std::string transmission, std::string drivingMode, int maxVelocity, int weight);

    void addEngine(engine);

    void addWheel(wheel);

private:
    std::string _type{""};
    std::string _colour{""};
    int _serialNr{0};
    time_t _prodDate{0};
    std::string _prodLoc{""};
    std::string _transmission{""};
    std::string _drivingMode{""};
    int _maxVelocity{0};
    int _weight{0};

    engine _engine;
    wheel _wheel;
};

std::ostream &operator<<(std::ostream &, const car &);
std::istream &operator>>(std::istream&, car&);
void operator>>(wheel&, car&);
void operator>>(engine&, car&);


#endif //SRC_CAR_H
