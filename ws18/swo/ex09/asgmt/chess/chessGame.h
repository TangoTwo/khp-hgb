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

    void placeOnBoard(chessboard::Coord coord, chessman* chessman);

    bool pickupFigure(chessboard::Coord coord);

    bool placeFigure(chessboard::Coord coord);

    unsigned int getSize() const { return _chessboard.getSize();};

    std::ostream &print(std::ostream &os);

private:
    unsigned int _boardSize;
    chessboard _chessboard;
    Player _currentPlayer{Player::WHITE};
    chessman *_selectedFigure{nullptr};
};


#endif //CHESS_CHESSPRINTER_H
