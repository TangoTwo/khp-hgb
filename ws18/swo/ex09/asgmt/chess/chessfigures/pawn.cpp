//
// Created by khp on 06.12.18.
//

#include "pawn.h"
#include "../global.h"
#include "symbols.h"

pawn::pawn(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_PAWN;
    _symbolBlackU8 = SYMBOL_PAWN_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_PAWN_WHITE_U8;
}

bool pawn::canMoveTo(const unsigned int col, const unsigned int row) const {
    return false;
}
