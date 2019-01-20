//
// Created by khp on 06.12.18.
//

#include "bishop.h"
#include "symbols.h"

bishop::bishop(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_BISHOP;
    _symbolBlackU8 = SYMBOL_BISHOP_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_BISHOP_WHITE_U8;
}

bool bishop::canMoveTo(Coord from, Coord to, const chessboard *chessboard) const {
    char multiplicatorRow = 1;
    char multiplicatorCol = 1;
    if (chessboard->getChessman(to) != nullptr && chessboard->getChessman(to)->getColour() == this->getColour())
        return false;
    if (abs(int(to.first - from.first)) - abs(int(to.second - from.second)) != 0)
        return false;
    if (to.first < from.first)
        multiplicatorRow = -1;
    if (to.second < from.second)
        multiplicatorCol = -1;
    for (unsigned int i = multiplicatorCol; i < to.second - from.second; i += multiplicatorCol) {
        if (chessboard->getChessman(Coord(from.first + (i * multiplicatorRow), from.second + (i * multiplicatorCol))) !=
            nullptr)
            return false;
    }
    return true;
}