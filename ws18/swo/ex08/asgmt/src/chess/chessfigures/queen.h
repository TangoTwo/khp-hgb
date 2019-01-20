//
// Created by khp on 06.12.18.
//

#ifndef SWO_QUEEN_H
#define SWO_QUEEN_H


#include "../chessman.h"
#include "../global.h"

class queen : public chessman {
public:
    queen(Colour colour);

    bool canMoveTo(Coord from, Coord to, const chessboard *chessboard) const override;
};


#endif //SWO_QUEEN_H
