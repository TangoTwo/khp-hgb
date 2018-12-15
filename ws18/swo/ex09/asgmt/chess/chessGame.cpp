//
// Created by khp on 13.12.18.
//

#include <iostream>
#include "chessGame.h"

chessGame::chessGame(unsigned int boardSize) : chessboard{boardSize} {
    std::cout << "Create Chessboard" << std::endl;
}

std::ostream &chessGame::print(std::ostream &os) {
    for (unsigned int i = 0; i < _chessboard.getSize(); ++i) {
        for (unsigned int j = 0; j < _chessboard.getSize(); ++j) {
            chessman *tFigure = _chessboard.getChessman(i, j);

            os << " | ";
            if (_selectedFigure)


        }
        os << " | " << std::endl;
    }
    return os;
}

