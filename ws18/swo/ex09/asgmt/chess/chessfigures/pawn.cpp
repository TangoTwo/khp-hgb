//
// Created by khp on 06.12.18.
//

#include "pawn.h"
#include "symbols.h"

pawn::pawn(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_PAWN;
    _symbolBlackU8 = SYMBOL_PAWN_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_PAWN_WHITE_U8;
}

bool pawn::canMoveTo(Coord from, Coord to, const chessboard *chessboard) const {
    char multiplicator = 1;
    if (this->_colour == Colour::BLACK)
        multiplicator = -1;

    if (chessboard->getChessman(to) != nullptr) {
        if (((to.first == from.first + 1) || (to.first == from.first - 1)) && to.second == from.second + multiplicator)
            return true;
    } else if (to.second == from.second + multiplicator && to.first == from.first) // normal pawn move
        return true;
    else if (_moveCount == 0 && to.second == from.second + 2 * multiplicator &&
             to.first == from.first) // start pawn move = 2 fields
        return true;
    return false;
}
