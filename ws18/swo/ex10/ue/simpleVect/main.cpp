//
// Created by khp on 10.12.18.
//

#include <iostream>
#include "simpleVector.h"

using std::cout;
using std::endl;

int main() {
    try {
        swo::simpleVector v1{5};
        swo::simpleVector *p_v2 = new swo::simpleVector{10};
        for (int i = 0; i < v1.size(); ++i) {
            v1[i] = i*10;
        }
        swo::simpleVector v2(-1);

        delete p_v2; // won't be reached! Lost memory
    } catch (std::exception &excpt){
        std::cerr << "ERROR: " << excpt.what() << std::endl;
    }
}