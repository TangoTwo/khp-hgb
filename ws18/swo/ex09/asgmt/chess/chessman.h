//
// Created by khp on 06.12.18.
//

#ifndef SWO_CHESSMAN_H
#define SWO_CHESSMAN_H


#include <vector>
#include <string>

class chessman {
public:
    enum class Colour : bool {
        WHITE, BLACK
    };
    typedef std::pair<int, int> RelCoord;
    typedef std::pair<std::string, int> Coord;

    virtual int getColour() { return _colour; };

    virtual std::string getSymbol();

    virtual bool isEssential() { return _essential; };

    virtual bool canMoveTo() = 0;

protected:
    Colour _colour;
    char _symbol;
    std::string _symbolWhiteU8;
    std::string _symbolBlackU8;
    bool _essential;
    std::vector<RelCoord> _moveVect;
    Coord pos;
};


#endif //SWO_CHESSMAN_H
