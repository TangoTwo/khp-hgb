//
// Created by khp on 06.12.18.
//

#include "knight.h"
#include "../global.h"
#include "symbols.h"

knight::knight(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_KNIGHT;
    _symbolBlackU8 = SYMBOL_KNIGHT_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_KNIGHT_WHITE_U8;
}

bool knight::canMoveTo(const unsigned int col, const unsigned int row) const {
    return false;
}