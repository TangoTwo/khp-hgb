//
// Created by khp on 06.12.18.
//

#include "chessboard.h"
#include "chessman.h"

chessboard::chessboard(unsigned int size) {
    for (int i = 0; i < size; ++i) {
        std::vector<chessman *> tVect;
        for (int j = 0; j < size; ++j) {
            tVect.push_back(nullptr);
        }
        _chessVect.push_back(tVect);
    }
}

chessman *chessboard::getChessman(const unsigned int col, const unsigned int row) const {
    if (col > _chessVect.size() || row > _chessVect.size())
        throw;
    return _chessVect[row][col];
}

chessman *chessboard::getChessman(Coord coord) const {
    unsigned int tCol = std::toupper(coord.first) - 'A';
    coord.second--;
    if(tCol > this->getSize() || coord.second > this->getSize())
        throw;
    return getChessman(tCol, coord.second);
}

unsigned int chessboard::getSize() const{
    return (unsigned int) _chessVect.size();
}

void chessboard::placeChessman(const unsigned int col, const unsigned int row, chessman* chessman) {
    if(col > this->getSize() || row > this->getSize())
        throw;
    _chessVect[col][row] = chessman;
}
