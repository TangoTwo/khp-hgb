//
// Created by khp on 06.12.18.
//

#ifndef SWO_ROOK_H
#define SWO_ROOK_H


#include "../chessman.h"
#include "../global.h"

class rook : public chessman {
public:
    rook(Colour colour);

    bool canMoveTo(Coord from, Coord to, const chessboard *chessboard) const override;
};


#endif //SWO_ROOK_H
