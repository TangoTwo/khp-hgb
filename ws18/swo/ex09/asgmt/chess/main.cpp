//
// Created by khp on 06.12.18.
//

#include <iostream>
#include <cstring>
#include "chessGame.h"
#include "chessfigures/bishop.h"
#include "chessfigures/rook.h"
#include "chessfigures/queen.h"
#include "chessfigures/king.h"
#include "chessfigures/knight.h"
#include "exceptions.h"

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

    /*for (int i = 0; i < cG.getSize(); ++i) {
        cG.placeOnBoard(toCoord(('A' + i), 2), new pawn(chessman::Colour::WHITE));
        cG.placeOnBoard(toCoord(('A' + i), 7), new pawn(chessman::Colour::BLACK));
    }*/
    cG.placeOnBoard(toCoord('A', 1), new rook(chessman::Colour::WHITE));
    cG.placeOnBoard(toCoord('H', 1), new rook(chessman::Colour::WHITE));

    cG.placeOnBoard(toCoord('A', 8), new rook(chessman::Colour::BLACK));
    cG.placeOnBoard(toCoord('H', 8), new rook(chessman::Colour::BLACK));

    cG.placeOnBoard(toCoord('B', 1), new knight(chessman::Colour::WHITE));
    cG.placeOnBoard(toCoord('G', 1), new knight(chessman::Colour::WHITE));

    cG.placeOnBoard(toCoord('B', 8), new knight(chessman::Colour::BLACK));
    cG.placeOnBoard(toCoord('G', 8), new knight(chessman::Colour::BLACK));

    cG.placeOnBoard(toCoord('C', 1), new bishop(chessman::Colour::WHITE));
    cG.placeOnBoard(toCoord('F', 4), new bishop(chessman::Colour::WHITE));

    cG.placeOnBoard(toCoord('C', 8), new bishop(chessman::Colour::BLACK));
    cG.placeOnBoard(toCoord('F', 8), new bishop(chessman::Colour::BLACK));

    cG.placeOnBoard(toCoord('E', 8), new king(chessman::Colour::BLACK));
    cG.placeOnBoard(toCoord('E', 1), new king(chessman::Colour::WHITE));

    cG.placeOnBoard(toCoord('D', 8), new queen(chessman::Colour::BLACK));
    cG.placeOnBoard(toCoord('D', 1), new queen(chessman::Colour::WHITE));

    bool gameOver = false;
    while (!gameOver) {
        std::cout << std::endl << std::endl;
        std::cout << "Next Player is " << (cG.getPlayer() == chessman::Colour::WHITE ? "White" : "Black") << std::endl;
        cG.print(std::cout);
        std::string tString;
        std::cout << "Pickup figure" << std::endl;
        std::cin >> tString;
        if (cG.pickupFigure(toCoord((char) tString[0], std::stoi(tString.substr(1))))) {
            cG.print(std::cout);
            std::cout << "Place figure!" << std::endl;
            std::cin >> tString;
            try {
                if (cG.placeFigure(toCoord((char) tString[0], std::stoi(tString.substr(1))))) {
                    std::cout << "Placed figure!" << std::endl;
                } else {
                    std::cout << "Can't place figure here!" << std::endl;
                }
            } catch (GameOverException &e) {
                gameOver = true;
            }
        } else {
            std::cout << "Can't pick up this figure!" << std::endl;
        }
        cG.dropFigure();
    }
    return 0;
}