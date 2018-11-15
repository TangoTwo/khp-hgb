#ifndef GAMEBOARD_H
#define GAMEBOARD_H

#include <stdbool.h>
#include "types.h"

#define GB_ROWS 22
#define GB_COLS 11

bool gb_valid_pos(const position pos);
extern void gb_add_block(const block);
extern void gb_render(void);

#endif
