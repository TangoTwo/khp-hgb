//
// Created by khp on 06.12.18.
//

#ifndef SWO_PAWN_H
#define SWO_PAWN_H


#include "../chessman.h"
#include "../chessboard.h"

class pawn : public chessman {
public:
    pawn(Colour colour);

    bool canMoveTo(Coord from, Coord to, const chessboard *chessboard) const override;
};


#endif //SWO_PAWN_H
