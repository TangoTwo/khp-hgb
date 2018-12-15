//
// Created by khp on 06.12.18.
//

#ifndef SWO_ROOK_H
#define SWO_ROOK_H


#include "../chessman.h"

class rook : public chessman {
public:
    rook(Colour colour);

    virtual bool canMoveTo(unsigned int col, unsigned int row) const override;
};


#endif //SWO_ROOK_H
