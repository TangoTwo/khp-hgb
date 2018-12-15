//
// Created by khp on 06.12.18.
//

#include "king.h"
#include "../global.h"
#include "symbols.h"

king::king(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_KING;
    _symbolBlackU8 = SYMBOL_KING_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_KING_WHITE_U8;
}

bool king::canMoveTo(const unsigned int col, const unsigned int row) const {
    return false;
}