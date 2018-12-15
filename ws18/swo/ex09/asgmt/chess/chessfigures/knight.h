//
// Created by khp on 06.12.18.
//

#ifndef SWO_KNIGHT_H
#define SWO_KNIGHT_H


#include "../chessman.h"

class knight : public chessman {
public:
    knight(Colour colour);

    virtual bool canMoveTo(unsigned int col, unsigned int row) const override;
};


#endif //SWO_KNIGHT_H
