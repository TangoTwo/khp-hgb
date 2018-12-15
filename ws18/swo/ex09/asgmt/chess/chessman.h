//
// Created by khp on 06.12.18.
//

#ifndef SWO_CHESSMAN_H
#define SWO_CHESSMAN_H


#include <vector>
#include <string>

class chessman {
public:
    typedef std::pair<char, unsigned int> Coord;
    enum class Colour : bool {
        WHITE, BLACK
    };
    typedef std::pair<int, int> RelCoord;

    virtual Colour getColour() { return _colour; };

    virtual std::string getSymbol() const;

    virtual bool isEssential() { return _essential; };

    virtual bool canMoveTo(Coord) const;
    virtual bool canMoveTo(const unsigned int col, const unsigned int row) const = 0;

protected:
    Colour _colour;
    char _symbol;
    std::string _symbolWhiteU8;
    std::string _symbolBlackU8;
    bool _essential;
    std::vector<RelCoord> _moveVect;
};


#endif //SWO_CHESSMAN_H
