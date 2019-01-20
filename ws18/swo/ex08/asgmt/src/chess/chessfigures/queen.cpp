//
// Created by khp on 06.12.18.
//

#include "queen.h"
#include "symbols.h"
#include "rook.h"
#include "bishop.h"

queen::queen(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_QUEEN;
    _symbolBlackU8 = SYMBOL_QUEEN_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_QUEEN_WHITE_U8;
}

bool queen::canMoveTo(Coord from, Coord to, const chessboard *chessboard) const {
    if (chessboard->getChessman(to) != nullptr && chessboard->getChessman(to)->getColour() == this->getColour())
        return false;
    // lifehacking here
    rook tRook(this->getColour());
    if (tRook.canMoveTo(from, to, chessboard))
        return true;
    else {
        bishop tBishop(this->getColour());
        if (tBishop.canMoveTo(from, to, chessboard))
            return true;
    }
    return false;
}