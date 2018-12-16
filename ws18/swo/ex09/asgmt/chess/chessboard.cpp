//
// Created by khp on 06.12.18.
//

#include <stdexcept>
#include "chessboard.h"
#include "exceptions.h"

#define MIN_SIZE 6
chessboard::chessboard(unsigned int size) {
    if (size < MIN_SIZE) {
        throw ChessboardTooSmallException();
    }
    for (int i = 0; i < size; ++i) {
        std::vector<chessman *> tVect;
        for (int j = 0; j < size; ++j) {
            tVect.push_back(nullptr);
        }
        _chessVect.push_back(tVect);
    }
}

chessman *chessboard::getChessman(Coord coord) const {
    exceptIfOutOfBounds(coord);
    if (coord.first > _chessVect.size() || coord.second > _chessVect.size())
        throw NoChessmanException();
    return _chessVect[coord.first][coord.second];
}

unsigned int chessboard::getSize() const{
    return (unsigned int) _chessVect.size();
}

void chessboard::placeChessman(Coord coord, chessman *chessman) {
    exceptIfOutOfBounds(coord);
    _chessVect[coord.first][coord.second] = chessman;
}

void chessboard::moveChessman(Coord from, Coord to) {
    exceptIfOutOfBounds(from);
    exceptIfOutOfBounds(to);

    if (this->getChessman(from) == nullptr)
        throw NoChessmanException();
    else if (this->getChessman(to) != nullptr && this->getChessman(to)->isEssential())
        throw GameOverException();

    if (_chessVect[to.first][to.second] != nullptr)
        delete (_chessVect[to.first][to.second]);
    _chessVect[to.first][to.second] = _chessVect[from.first][from.second];
    _chessVect[from.first][from.second] = nullptr;
}

void chessboard::exceptIfOutOfBounds(Coord coord) const {
    if (coord.first > this->getSize() || coord.first > this->getSize())
        throw std::range_error("Out of bounds!");
}

Coord toCoord(char col, unsigned int row) {
    Coord tCoord;
    tCoord.first = std::toupper(col) - 'A';
    tCoord.second = row - 1;
    return tCoord;
}