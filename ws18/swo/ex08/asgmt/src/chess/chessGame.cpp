//
// Created by khp on 13.12.18.
//

#include <iostream>
#include "chessGame.h"

chessGame::chessGame(unsigned int boardSize) : _chessboard{boardSize} {
    std::cout << "Created chessboard with size " << boardSize << std::endl;
}

std::ostream &chessGame::print(std::ostream &os) const {
    os << "  |";
    for (unsigned int k = 0; k < _chessboard.getSize(); ++k) {
        os << " " << char('a' + k) << " ";
    }
    os << "|  " << std::endl;
    os << "--+";
    for (unsigned int k = 0; k < _chessboard.getSize(); ++k) {
        os << "---";
    }
    os << "+--" << std::endl;
    for (int i = _chessboard.getSize()-1; i >= 0; --i) {
        os << i + 1 << " |";
        for (unsigned int j = 0; j < _chessboard.getSize(); ++j) {
            chessman *tFigure = _chessboard.getChessman(Coord(j, i));


            bool tCanMove = false;
            if (_selectedFigure != nullptr)
                tCanMove = _selectedFigure->canMoveTo(_selectedFigureCoord, Coord(j, i), &_chessboard);

            if (tFigure == nullptr){
                tCanMove ? os << "[" : os << " ";
                (i + j) % 2 ? os << "." : os << "*";
                tCanMove ? os << "]" : os << " ";
            } else if(tFigure == _selectedFigure) {
                os << "(" << tFigure->getSymbol() << ")";
            } else {
                tCanMove ? os << "[" : os << " ";
                os << tFigure->getSymbol();
                tCanMove ? os << "]" : os << " ";
            }
        }
        os << "| " << i + 1<< std::endl;
    }
    os << "--+";
    for (unsigned int k = 0; k < _chessboard.getSize(); ++k) {
        os << "---";
    }
    os << "+--" << std::endl;
    os << "  |";
    for (unsigned int k = 0; k < _chessboard.getSize(); ++k) {
        os << " " << char('a' + k) << " ";
    }
    os << "|  " << std::endl;
    return os;
}

void chessGame::placeOnBoard(Coord coord, chessman *chessman) {
    _chessboard.placeChessman(coord, chessman);
}

bool chessGame::pickupFigure(Coord coord) {
    if (coord.first > _chessboard.getSize() ||
        coord.second > _chessboard.getSize())
        return false;
    chessman *tChessman = _chessboard.getChessman(coord);
    if (tChessman == nullptr)
        return false;
    else if (tChessman->getColour() != _currentPlayerColour)
        return false;
    _selectedFigure = tChessman;
    _selectedFigureCoord = coord;
    return true;
}

bool chessGame::placeFigure(Coord coord) {
    if (_selectedFigure->canMoveTo(_selectedFigureCoord, coord, &_chessboard)) {
        _chessboard.moveChessman(_selectedFigureCoord, coord);
        _selectedFigure->increaseMoveCount();
        _selectedFigureCoord = Coord(0, 0);
        _selectedFigure = nullptr;
        _currentPlayerColour == chessman::Colour::BLACK ?
                _currentPlayerColour = chessman::Colour::WHITE :
                _currentPlayerColour = chessman::Colour::BLACK;
        return true;
    }
    return false;
}

void chessGame::dropFigure() {
    _selectedFigure = nullptr;
    _selectedFigureCoord = Coord(0, 0);
}

std::ostream &operator<<(std::ostream &os, const chessGame &cG) {
    cG.print(os);
    return os;
}

