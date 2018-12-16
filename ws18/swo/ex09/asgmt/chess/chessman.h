//
// Created by khp on 06.12.18.
//

#ifndef SWO_CHESSMAN_H
#define SWO_CHESSMAN_H


#include <vector>
#include <string>
#include "global.h"
#include "chessboard.h"

class chessboard;
class chessman {
public:
    enum class Colour : bool {
        WHITE, BLACK
    };

    virtual Colour getColour() const { return _colour; };

    virtual std::string getSymbol() const;

    virtual bool isEssential() { return _essential; };

    virtual void increaseMoveCount() { _moveCount++; };

    virtual bool canMoveTo(Coord from, Coord to, const chessboard *chessboard) const = 0;

protected:
    Colour _colour;
    char _symbol;
    std::string _symbolWhiteU8;
    std::string _symbolBlackU8;
    bool _essential;
    unsigned int _moveCount{0};
};


#endif //SWO_CHESSMAN_H
