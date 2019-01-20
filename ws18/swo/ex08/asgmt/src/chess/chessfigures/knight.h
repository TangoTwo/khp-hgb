//
// Created by khp on 06.12.18.
//

#ifndef SWO_KNIGHT_H
#define SWO_KNIGHT_H


#include "../chessman.h"
#include "../global.h"

class knight : public chessman {
public:
    knight(Colour colour);

    virtual bool canMoveTo(Coord from, Coord to, const chessboard *chessboard) const override;
};


#endif //SWO_KNIGHT_H
