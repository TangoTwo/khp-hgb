//
// Created by khp on 06.12.18.
//

#ifndef SWO_PAWN_H
#define SWO_PAWN_H


#include "../chessman.h"

class pawn : public chessman {
public:
    pawn(int colour);

    bool canMoveTo() override;

};


#endif //SWO_PAWN_H
