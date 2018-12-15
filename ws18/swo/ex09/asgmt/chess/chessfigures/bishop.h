//
// Created by khp on 06.12.18.
//

#ifndef SWO_BISHOP_H
#define SWO_BISHOP_H


#include "../chessman.h"

class bishop : public chessman {
public:
    bishop(Colour colour);

    virtual bool canMoveTo(unsigned int col, unsigned int row) const override;
};


#endif //SWO_BISHOP_H
