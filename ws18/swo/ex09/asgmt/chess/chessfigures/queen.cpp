//
// Created by khp on 06.12.18.
//

#include "queen.h"
#include "../global.h"
#include "symbols.h"

queen::queen(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_QUEEN;
    _symbolBlackU8 = SYMBOL_QUEEN_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_QUEEN_WHITE_U8;
}

bool queen::canMoveTo(const unsigned int col, const unsigned int row) const {
    return false;
}