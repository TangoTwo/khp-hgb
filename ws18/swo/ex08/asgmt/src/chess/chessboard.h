//
// Created by khp on 06.12.18.
//

#ifndef SWO_CHESSBOARD_H
#define SWO_CHESSBOARD_H

#include <string>
#include "global.h"
#include "chessman.h"

class chessman;
class chessboard {
public:
    explicit chessboard(unsigned int size = DEFAULT_CHESSBOARD_SIZE);

    unsigned int getSize() const;

    void placeChessman(Coord coord, chessman *chessman);

    void moveChessman(Coord from, Coord to);

    chessman *getChessman(Coord coord) const;



private:
    void exceptIfOutOfBounds(Coord coord) const;
    std::vector<std::vector<chessman *>> _chessVect;
};

Coord toCoord(char, unsigned int);


#endif //SWO_CHESSBOARD_H
