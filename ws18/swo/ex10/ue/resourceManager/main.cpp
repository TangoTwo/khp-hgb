//
// Created by khp on 10.12.18.
//

#include <iostream>
#include "resourceManager.h"

static resourceManager getRM() {
    resourceManager rm("X");
    rm.use();
    return rm;
}
int main() {
    resourceManager rm1("R1");
    resourceManager rm2("R2");
    //resourceManager rm3(rm1);
    //rm3 = rm2;

    resourceManager rm3(std::move(rm1));

    std::cout << "rm1.use()" << std::endl;
    rm1.use();
    std::cout << "rm2.use()" << std::endl;
    rm2.use();
    std::cout << "rm3.use()" << std::endl;
    rm3.use();

    resourceManager r4 = getRM();
    std::cout << "rm4.use()" << std::endl;
    r4.use();
}