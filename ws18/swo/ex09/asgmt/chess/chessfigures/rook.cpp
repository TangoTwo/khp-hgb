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

/*
bool rook::canMoveTo(Coord from, Coord to, const chessboard* chessboard) const {
    if(chessboard->getChessman(to) != nullptr && chessboard->getChessman(to)->getColour() == this->getColour())
        return false;

    if(to.first != from.first && to.second != from.second)
        return false;
    if(to.first == from.first){
        if(to.second > from.second){
            for (unsigned int i = from.second + 1 ; i < to.second -1; ++i) {
                if(chessboard->getChessman(Coord(to.first, i)) != nullptr)
                    return false;
            }
        }
        else if(to.second < from.second){
            for (unsigned int i = to.second + 1; i < from.second -1; ++i) {
                if(chessboard->getChessman(Coord(to.first, i)) != nullptr)
                    return false;
            }
        }
        return true;
    }
    else if(to.second == from.second){
        if(to.first > from.first){
            for (unsigned int i = from.first + 1; i < to.first - 1; ++i) {
                if(chessboard->getChessman(Coord(i, to.second)) != nullptr)
                    return false;
            }
        }
        else if(to.first < from.first){
            for (unsigned int i = to.first + 1; i < from.first - 1; ++i) {
                if(chessboard->getChessman(Coord(i, to.second)) != nullptr)
                    return false;
            }
        }
        return true;
    }
}*/
bool rook::canMoveTo(Coord from, Coord to, const chessboard *chessboard) const {

    char multiplicatorCol = 1;
    if (chessboard->getChessman(to) != nullptr && chessboard->getChessman(to)->getColour() == this->getColour())
        return false;
    if (to.first != from.first && to.second != from.second)
        return false;
    else if (to.first != from.first) {
        char multiplicator = 1;
        if (to.first < from.first)
            multiplicator = -1;
        for (int i = multiplicator; i < to.first - from.first; i += multiplicatorCol) {
            if (chessboard->getChessman(Coord(from.first + (i * multiplicator), to.second)) !=
                nullptr)
                return false;
        }
    } else if (to.second != from.second) {
        char multiplicator = 1;
        if (to.second < from.second)
            multiplicator = -1;
        for (int i = multiplicator; i < to.second - from.second; i += multiplicatorCol) {
            if (chessboard->getChessman(Coord(to.first, from.second + (i * multiplicator))) !=
                nullptr)
                return false;
        }
    }
    return true;
}