//
// Created by khp on 13.12.18.
//

#include <iostream>
#include "chessGame.h"

chessGame::chessGame(unsigned int boardSize) : _chessboard{boardSize} {
    std::cout << "Created chessboard with size " << boardSize << std::endl;
}

std::ostream &chessGame::print(std::ostream &os) {
    os << "  |";
    for (int k = 0; k < _chessboard.getSize(); ++k) {
        os << " " << char('a' + k) << " ";
    }
    os << "|  " << std::endl;
    os << "--+";
    for (int k = 0; k < _chessboard.getSize(); ++k) {
        os << "---";
    }
    os << "+--" << std::endl;
    for (int i = _chessboard.getSize()-1; i >= 0; --i) {
        os << i + 1 << " |";
        for (unsigned int j = 0; j < _chessboard.getSize(); ++j) {
            chessman *tFigure = _chessboard.getChessman(i, j);



            if (tFigure == nullptr){
                (i + j) % 2 ? os << " . " : os << " * ";
            } else if(tFigure == _selectedFigure) {
                os << "(" << tFigure->getSymbol() << ")";
            } else {
                bool tCanMove = false;
                if(_selectedFigure != nullptr)
                    tCanMove = _selectedFigure->canMoveTo(i, j);
                tCanMove ? os << "[" : os << " ";
                os << tFigure->getSymbol();
                tCanMove ? os << "]" : os << " ";
            }
        }
        os << "| " << i + 1<< std::endl;
    }
    os << "--+";
    for (int k = 0; k < _chessboard.getSize(); ++k) {
        os << "---";
    }
    os << "+--" << std::endl;
    os << "  |";
    for (int k = 0; k < _chessboard.getSize(); ++k) {
        os << " " << char('a' + k) << " ";
    }
    os << "|  " << std::endl;
    return os;
}

void chessGame::placeOnBoard(chessboard::Coord coord, chessman* chessman) {
    unsigned int tCol = std::toupper(coord.first) - 'A';
    coord.second--;
    if(tCol > _chessboard.getSize() || coord.second > _chessboard.getSize())
        throw;
    _chessboard.placeChessman(tCol, coord.second, chessman);
}

