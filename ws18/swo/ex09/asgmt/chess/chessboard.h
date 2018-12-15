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
    explicit chessboard(unsigned int size = DEFAULT_CHESSBOARD_SIZE);

    unsigned int getSize();

    chessman *getChessman(unsigned int col, unsigned int row) const;

    chessman *getChessman(char col, unsigned int row) const;

private:
    std::vector<std::vector<chessman *>> chessVect;
};


#endif //SWO_CHESSBOARD_H
