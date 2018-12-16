//
// Created by khp on 13.12.18.
//

#ifndef CHESS_CHESSPRINTER_H
#define CHESS_CHESSPRINTER_H


#include "chessboard.h"
#include "global.h"
#include "chessman.h"

class chessGame {
public:
    chessGame(unsigned int boardSize = DEFAULT_CHESSBOARD_SIZE);

    void placeOnBoard(Coord coord, chessman *chessman);

    bool pickupFigure(Coord coord);

    void dropFigure();

    bool placeFigure(Coord coord);

    chessman::Colour getPlayer() const { return _currentPlayerColour; };

    std::ostream &print(std::ostream &os);

private:
    unsigned int _boardSize;
    chessboard _chessboard;
    chessman::Colour _currentPlayerColour{chessman::Colour::WHITE};
    chessman *_selectedFigure{nullptr};
    Coord _selectedFigureCoord{Coord(0, 0)};
};


#endif //CHESS_CHESSPRINTER_H
