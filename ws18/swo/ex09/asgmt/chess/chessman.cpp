//
// Created by khp on 06.12.18.
//

#include <locale>
#include "chessman.h"

std::string chessman::getSymbol() const{

bool UTF_8 = true;
std::string chessman::getSymbol() {
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
            case Colour::WHITE:
                return std::string{_symbol};
            case Colour::BLACK:
                std::locale loc;
                return std::string{_symbol + ASCII_TOUPPER_OFFSET};
        }
    }
    return std::string{};
}

