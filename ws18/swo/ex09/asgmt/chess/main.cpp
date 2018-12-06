//
// Created by khp on 06.12.18.
//

#include <iostream>
#include <cstring>
#include "chessfigures/bishop.h"
#include "chessfigures/pawn.h"

extern bool UTF_8;

int main(int argc, char *argv[]) {
    if (argc == 2 && std::strncmp(argv[1], "-u", 2) == 0) {
        std::cout << "UTF-8 Mode enabled!" << std::endl;
        UTF_8 = true;
    } else if ((argc > 1)) {
        std::cerr << "Usage: " << argv[0] << " [-u]" << std::endl;
        return EXIT_FAILURE;
    }
    pawn pawnB(pawn::COLOUR_BLACK);
    pawn pawnW(pawn::COLOUR_WHITE);
    std::cout << pawnB.getSymbol() << "-" << pawnW.getSymbol();
    return 0;
}