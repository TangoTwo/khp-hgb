//
// Created by khp on 06.12.18.
//

#ifndef SWO_KING_H
#define SWO_KING_H


#include "../chessman.h"
#include "../global.h"

class king : public chessman {
public:
    king(Colour colour);

    bool canMoveTo(Coord from, Coord to, const chessboard *chessboard) const override;
};


#endif //SWO_KING_H
