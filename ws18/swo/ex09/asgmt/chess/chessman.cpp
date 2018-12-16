//
// Created by khp on 06.12.18.
//

#include "chessman.h"

std::string chessman::getSymbol() const{
    if (UTF_8) {
        switch (_colour) {
            case Colour::WHITE:
                return _symbolWhiteU8;
            case Colour::BLACK:
                return _symbolBlackU8;
            default:
                break;
        }
    } else {
        switch (_colour) {
            case Colour::BLACK:
                return std::string{_symbol};
            case Colour::WHITE:
                return std::string{(_symbol + ASCII_TOUPPER_OFFSET)};
        }
    }
    return std::string{};
}
