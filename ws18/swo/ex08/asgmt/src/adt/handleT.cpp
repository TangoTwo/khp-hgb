//
// Created by khp on 01.12.18.
//

#include "handleT.h"

handle_t::handle_t(unsigned long int id) {
    this->id = id;
}

unsigned long int handle_t::getID() const{
    return this->id;
}
