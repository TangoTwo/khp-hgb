//
// Created by khp on 06.12.18.
//

#include <locale>
#include "chessman.h"
#include "global.h"
#include "chessfigures/symbols.h"

std::string chessman::getSymbol() const{
    if (UTF_8) {
        switch (_colour) {
            case COLOUR_WHITE:
                return _symbolWhiteU8;
            case COLOUR_BLACK:
                return _symbolBlackU8;
            default:
                break;
        }
    } else {
        switch (_colour) {
            case COLOUR_WHITE:
                return std::string{_symbol};
            case COLOUR_BLACK:
                std::locale loc;
                return std::string{_symbol + ASCII_TOUPPER_OFFSET};
        }
    }
    return std::string{};
}

