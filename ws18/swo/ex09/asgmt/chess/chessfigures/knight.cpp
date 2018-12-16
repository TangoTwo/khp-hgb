//
// Created by khp on 06.12.18.
//

#include "knight.h"
#include "symbols.h"

knight::knight(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_KNIGHT;
    _symbolBlackU8 = SYMBOL_KNIGHT_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_KNIGHT_WHITE_U8;
}

bool knight::canMoveTo(Coord from, Coord to, const chessboard *chessboard) const {
    if (chessboard->getChessman(to) != nullptr && chessboard->getChessman(to)->getColour() == this->getColour())
        return false;
    if (to.first == from.first + 2 || to.first == from.first - 2) {
        return to.second == from.second + 1 || to.second == from.second - 1;
    } else if (to.second == from.second + 2 || to.second == from.second - 2) {
        return to.first == from.first + 1 || to.first == from.first - 1;
    }
    return false;
}