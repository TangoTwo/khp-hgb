//
// Created by khp on 30.11.18.
//

#ifndef SRC_ENGINE_H
#define SRC_ENGINE_H

#include <string>

class engine {
    friend std::ostream &operator<<(std::ostream&, const engine&);
    friend std::istream &operator>>(std::istream&, engine&);
public:
    engine() = default;
    engine(unsigned int engineNum, std::string fuelType, unsigned int power, float consumption, time_t prodDate);

private:
    unsigned int _engineNum{0};
    std::string _fuelType{""};
    unsigned int _power{0};
    float _consumption{0.0};
    time_t _prodDate{0};
};
std::ostream &operator<<(std::ostream&, const engine&);
std::istream &operator>>(std::istream&, engine&);

#endif //SRC_ENGINE_H
