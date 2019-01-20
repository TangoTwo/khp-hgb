//
// Created by khp on 06.12.18.
//

#include "rook.h"
#include "symbols.h"

rook::rook(Colour colour) {
    _colour = colour;
    _symbol = SYMBOL_ROOK;
    _symbolBlackU8 = SYMBOL_ROOK_BLACK_U8;
    _symbolWhiteU8 = SYMBOL_ROOK_WHITE_U8;
}

bool rook::canMoveTo(Coord from, Coord to, const chessboard *chessboard) const {
    if (chessboard->getChessman(to) != nullptr && chessboard->getChessman(to)->getColour() == this->getColour())
        return false;
    if (to.first != from.first && to.second != from.second)
        return false;
    else if (to.first != from.first) {
        char multiplicator = 1;
        if (to.first < from.first)
            multiplicator = -1;
        for (int i = multiplicator; abs(i) < abs(to.first - from.first); i += multiplicator) {
            if (chessboard->getChessman(Coord(from.first + i, to.second)) !=
                nullptr)
                return false;
        }
    } else if (to.second != from.second) {
        char multiplicator = 1;
        if (to.second < from.second)
            multiplicator = -1;
        for (int i = multiplicator; abs(i) < abs(to.second - from.second); i += multiplicator) {
            if (chessboard->getChessman(Coord(to.first, from.second + i)) !=
                nullptr)
                return false;
        }
    }
    return true;
}