//
// Created by khp on 06.12.18.
//

#include <iostream>
#include <cstring>
#include "chessGame.h"
#include "chessfigures/bishop.h"
#include "chessfigures/pawn.h"
#include "chessfigures/rook.h"
#include "chessfigures/queen.h"
#include "chessfigures/king.h"
#include "chessfigures/knight.h"
#include "global.h"

bool UTF_8 = false;

int main(int argc, char *argv[]) {
    if (argc == 2 && std::strncmp(argv[1], "-u", 2) == 0) {
        std::cout << "UTF-8 Mode enabled!" << std::endl;
        UTF_8 = true;
    } else if ((argc > 1)) {
        std::cerr << "Usage: " << argv[0] << " [-u]" << std::endl;
        return EXIT_FAILURE;
    }

    chessGame cG;

    for (int i = 0; i < cG.getSize(); ++i) {
        cG.placeOnBoard(chessboard::Coord(('A' + i), 2), new pawn(chessman::Colour::WHITE));
        cG.placeOnBoard(chessboard::Coord(('A' + i), 7), new pawn(chessman::Colour::BLACK));
    }
    cG.placeOnBoard(chessboard::Coord('A', 1), new rook(chessman::Colour::WHITE));
    cG.placeOnBoard(chessboard::Coord('H', 1), new rook(chessman::Colour::WHITE));

    cG.placeOnBoard(chessboard::Coord('A', 8), new rook(chessman::Colour::BLACK));
    cG.placeOnBoard(chessboard::Coord('H', 8), new rook(chessman::Colour::BLACK));

    cG.placeOnBoard(chessboard::Coord('B', 1), new knight(chessman::Colour::WHITE));
    cG.placeOnBoard(chessboard::Coord('G', 1), new knight(chessman::Colour::WHITE));

    cG.placeOnBoard(chessboard::Coord('B', 8), new knight(chessman::Colour::BLACK));
    cG.placeOnBoard(chessboard::Coord('G', 8), new knight(chessman::Colour::BLACK));

    cG.placeOnBoard(chessboard::Coord('C', 1), new bishop(chessman::Colour::WHITE));
    cG.placeOnBoard(chessboard::Coord('F', 1), new bishop(chessman::Colour::WHITE));

    cG.placeOnBoard(chessboard::Coord('C', 8), new bishop(chessman::Colour::BLACK));
    cG.placeOnBoard(chessboard::Coord('F', 8), new bishop(chessman::Colour::BLACK));

    cG.placeOnBoard(chessboard::Coord('E', 8), new king(chessman::Colour::BLACK));
    cG.placeOnBoard(chessboard::Coord('E', 1), new king(chessman::Colour::WHITE));

    cG.placeOnBoard(chessboard::Coord('D', 8), new queen(chessman::Colour::BLACK));
    cG.placeOnBoard(chessboard::Coord('D', 1), new queen(chessman::Colour::WHITE));

    cG.print(std::cout);
    return 0;
}