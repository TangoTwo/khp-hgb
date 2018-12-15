//
// Created by khp on 06.12.18.
//

#include "rook.h"
#include "../global.h"
#include "symbols.h"

rook::rook(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_ROOK;
    _symbolBlackU8 = SYMBOL_ROOK_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_ROOK_WHITE_U8;
}

bool rook::canMoveTo(const unsigned int col, const unsigned int row) const {
    return false;
}