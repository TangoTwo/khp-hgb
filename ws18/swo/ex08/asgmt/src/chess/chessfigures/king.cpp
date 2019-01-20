//
// Created by khp on 06.12.18.
//

#include "king.h"
#include "symbols.h"

king::king(Colour colour) {
    _colour = colour;
    _essential = true;
    _symbol = SYMBOL_KING;
    _symbolBlackU8 = SYMBOL_KING_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_KING_WHITE_U8;
}

bool king::canMoveTo(Coord from, Coord to, const chessboard *chessboard) const {
    if (chessboard->getChessman(to) != nullptr && chessboard->getChessman(to)->getColour() == this->getColour())
        return false;
    return abs(int(to.first - from.first)) < 2 && abs(int(to.second - from.second)) < 2;
}