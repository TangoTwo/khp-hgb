//
// Created by khp on 06.12.18.
//

#ifndef SWO_QUEEN_H
#define SWO_QUEEN_H


#include "../chessman.h"

class queen : public chessman {
public:
    queen(Colour colour);

    virtual bool canMoveTo(unsigned int col, unsigned int row) const override;
};


#endif //SWO_QUEEN_H
