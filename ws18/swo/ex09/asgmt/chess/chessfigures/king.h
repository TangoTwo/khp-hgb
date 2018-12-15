//
// Created by khp on 06.12.18.
//

#ifndef SWO_KING_H
#define SWO_KING_H


#include "../chessman.h"

class king : public chessman {
public:
    king(Colour colour);

    virtual bool canMoveTo(unsigned int col, unsigned int row) const override;
};


#endif //SWO_KING_H
