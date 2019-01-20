#include <iostream>
#include "car.h"
#include "engine.h"
#include "wheel.h"

int main() {
    car car1;
    engine engine1;
    wheel wheel1;
    car car2;
    engine engine2;
    wheel wheel2;
    std::cout << "Enter car type, colour, serial number, production date, production location,"
                 " transmission type, driving mode, maximum speed and weight:" << std::endl;
    std::cin >> car1;
    std::cout << "Enter serial number, fuel type, horse power, consumption and production date of engine:" << std::endl;
    std::cin >> engine1;
    std::cout << "Enter diameter, production year, speed index and manufacturer of wheel:" << std::endl;
    std::cin >> wheel1;

    std::cout << "Enter car type, colour, serial number, production date, production location,"
                 " transmission type, driving mode, maximum speed and weight:" << std::endl;
    std::cin >> car2;
    std::cout << "Enter serial number, fuel type, horse power, consumption and production date of engine:" << std::endl;
    std::cin >> engine2;
    std::cout << "Enter diameter, production year, speed index and manufacturer of wheel:" << std::endl;
    std::cin >> wheel2;
    car1.addEngine(engine1);
    car1.addWheel(wheel1);
    car2.addEngine(engine2);
    car2.addWheel(wheel2);

    std::cout << "Car 1:" << std::endl << car1 << std::endl;
    std::cout << "Car 2:" << std::endl << car2 << std::endl;
}