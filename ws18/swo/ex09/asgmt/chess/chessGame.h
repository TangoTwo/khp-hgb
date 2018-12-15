//
// Created by khp on 13.12.18.
//

#ifndef CHESS_CHESSPRINTER_H
#define CHESS_CHESSPRINTER_H


#include "chessboard.h"
#include "global.h"

class chessGame {
    enum class Player : bool {
        WHITE, BLACK
    };
public:
    chessGame(unsigned int boardSize = DEFAULT_CHESSBOARD_SIZE);

    bool pickupFigure(char col, unsigned int row);

    bool placeFigure(char col, unsigned int row);

    std::ostream &print(std::ostream &os);

private:
    chessboard _chessboard;
    Player _currentPlayer{Player::WHITE};
    chessman *_selectedFigure{nullptr};
};


#endif //CHESS_CHESSPRINTER_H
