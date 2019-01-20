//
// Created by khp on 06.12.18.
//

#ifndef SWO_BISHOP_H
#define SWO_BISHOP_H


#include "../chessman.h"
#include "../chessboard.h"

class bishop : public chessman {
public:
    bishop(Colour colour);

    virtual bool canMoveTo(Coord from, Coord to, const chessboard *chessboard) const override;
};


#endif //SWO_BISHOP_H
