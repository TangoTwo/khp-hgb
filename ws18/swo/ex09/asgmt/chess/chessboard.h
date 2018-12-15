//
// Created by khp on 06.12.18.
//

#ifndef SWO_CHESSBOARD_H
#define SWO_CHESSBOARD_H

#include <string>
#include "global.h"
#include "chessman.h"

class chessboard {
public:
    typedef std::pair<char, unsigned int> Coord;
    explicit chessboard(unsigned int size = DEFAULT_CHESSBOARD_SIZE);

    unsigned int getSize() const;

    void placeChessman(unsigned int col, unsigned int row, chessman* chessman);

    chessman* getChessman(unsigned int col, unsigned int row) const;

    chessman *getChessman(Coord) const;

private:
    std::vector<std::vector<chessman *>> _chessVect;
};


#endif //SWO_CHESSBOARD_H
