//
// Created by khp on 06.12.18.
//

#include "bishop.h"
#include "../global.h"
#include "symbols.h"

bishop::bishop(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_BISHOP;
    _symbolBlackU8 = SYMBOL_BISHOP_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_BISHOP_WHITE_U8;
}

bool bishop::canMoveTo(const unsigned int col, const unsigned int row) const {
    return false;
}