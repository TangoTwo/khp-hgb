//
// Created by khp on 16.12.18.
//
#include <random>
#include <iostream>
#include "global.h"
#include "chessGame.h"
#include "chessfigures/pawn.h"
#include "chessfigures/bishop.h"
#include "chessfigures/rook.h"
#include "chessfigures/queen.h"
#include "chessfigures/king.h"
#include "chessfigures/knight.h"
#include "exceptions.h"
#include "gamemodes.h"

#define AMOUNT_CLEAR_LINES 8

void clearCmd() {
    if (CLEAR_CONSOLE)
        printf("\033c");
    else {
        for (int i = 0; i < AMOUNT_CLEAR_LINES; ++i) {
            std::cout << std::endl;
        }
    }
};

void placeDefaultSetup(chessGame *cG) {
    for (int i = 0; i < cG->getSize(); ++i) {
        cG->placeOnBoard(toCoord(('A' + i), 2), new pawn(chessman::Colour::WHITE));
        cG->placeOnBoard(toCoord(('A' + i), 7), new pawn(chessman::Colour::BLACK));
    }
    cG->placeOnBoard(toCoord('A', 1), new rook(chessman::Colour::WHITE));
    cG->placeOnBoard(toCoord('H', 1), new rook(chessman::Colour::WHITE));

    cG->placeOnBoard(toCoord('A', 8), new rook(chessman::Colour::BLACK));
    cG->placeOnBoard(toCoord('H', 8), new rook(chessman::Colour::BLACK));

    cG->placeOnBoard(toCoord('B', 1), new knight(chessman::Colour::WHITE));
    cG->placeOnBoard(toCoord('G', 1), new knight(chessman::Colour::WHITE));

    cG->placeOnBoard(toCoord('B', 8), new knight(chessman::Colour::BLACK));
    cG->placeOnBoard(toCoord('G', 8), new knight(chessman::Colour::BLACK));

    cG->placeOnBoard(toCoord('C', 1), new bishop(chessman::Colour::WHITE));
    cG->placeOnBoard(toCoord('F', 1), new bishop(chessman::Colour::WHITE));

    cG->placeOnBoard(toCoord('C', 8), new bishop(chessman::Colour::BLACK));
    cG->placeOnBoard(toCoord('F', 8), new bishop(chessman::Colour::BLACK));

    cG->placeOnBoard(toCoord('E', 8), new king(chessman::Colour::BLACK));
    cG->placeOnBoard(toCoord('E', 1), new king(chessman::Colour::WHITE));

    cG->placeOnBoard(toCoord('D', 8), new queen(chessman::Colour::BLACK));
    cG->placeOnBoard(toCoord('D', 1), new queen(chessman::Colour::WHITE));
}

void multiplayerGame() {
    chessGame cG;
    placeDefaultSetup(&cG);

    bool gameOver = false;
    while (!gameOver) {
        clearCmd();
        std::cout << "Next Player is " << (cG.getPlayer() == chessman::Colour::WHITE ? "White" : "Black") << std::endl;
        std::cout << cG;
        std::string tString;
        std::cout << "Pickup figure" << std::endl;
        std::cin >> tString;
        if (cG.pickupFigure(toCoord((char) tString[0], std::stoi(tString.substr(1))))) {
            clearCmd();
            std::cout << "Next Player is " << (cG.getPlayer() == chessman::Colour::WHITE ? "White" : "Black")
                      << std::endl;
            std::cout << cG;
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
}

void simulatedGame() {
    chessGame cG;
    placeDefaultSetup(&cG);

    bool gameOver = false;
    while (!gameOver) {
        clearCmd();
        std::cout << "Next Player is " << (cG.getPlayer() == chessman::Colour::WHITE ? "White" : "Black") << std::endl;
        std::cout << cG;
        srand(time(NULL));
        while (!cG.pickupFigure(Coord(rand() % (cG.getSize() - 1), rand() % (cG.getSize() - 1))));
        try {
            int i = 0;
            while (!cG.placeFigure(Coord(rand() % (cG.getSize() - 1), rand() % (cG.getSize() - 1))) && i++ < 20);
        } catch (GameOverException &e) {
            gameOver = true;
        }
    }
    clearCmd();
    std::cout << "Next Player is " << (cG.getPlayer() == chessman::Colour::WHITE ? "White" : "Black") << std::endl;
    std::cout << cG;
    std::cin; // wait for enter key
}