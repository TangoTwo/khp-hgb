//
// Created by khp on 06.12.18.
//

#include "chessboard.h"

chessboard::chessboard(unsigned int size) {
    for (int i = 0; i < size; ++i) {
        std::vector<chessman *> tVect;
        for (int j = 0; j < size; ++j) {
            tVect.push_back(nullptr);
        }
        chessVect.push_back(tVect);
    }
}

chessman *chessboard::getChessman(const unsigned int col, const unsigned int row) const {
    if (col > chessVect.size() || row > chessVect.size())
        throw;
    return chessVect[col][row];
}

chessman *chessboard::getChessman(char col, unsigned int row) const {
    unsigned int tCol = std::toupper(col) - 'A';
    row--;
    return getChessman(tCol, row);
}

unsigned int chessboard::getSize() {
    return (unsigned int) chessVect.size();
}
