//
// Created by khp on 06.12.18.
//

#include "pawn.h"
#include "../global.h"

pawn::pawn(int colour) {
    _colour = colour;
    if (UTF_8) {
        switch (_colour) {
            case COLOUR_WHITE:
                _symbol = u8"\u2659";
                break;
            case COLOUR_BLACK:
                _symbol = u8"\u265F";
                break;
            default:
                break;
        }
    } else {
        switch (_colour) {
            case COLOUR_WHITE:
                _symbol = u8"B";
                break;
            case COLOUR_BLACK:
                _symbol = u8"b";
                break;
            default:
                break;
        }
    }
}

bool pawn::canMoveTo() {
    return false;
}
