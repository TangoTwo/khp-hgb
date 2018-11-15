#include <stddef.h>
#include <assert.h>
#include "gameboard.h"

#define MAX_BLOCK_COUNT 100

static size_t block_count = 0;
static block blocks[MAX_BLOCK_COUNT];


bool gb_valid_pos(const position pos) {
    if (!(0 <= pos.x && pos.x < GB_COLS &&
        0 <= pos.y && pos.y < GB_ROWS))
        return false;
    for (int i = 0; i < block_count; ++i) {
        position p = blocks[i].pos;
        if (p.x == pos.x && p.y == pos.y)
            return false;
    }
    return true;
}

void gb_add_block(const block block) {
    assert(block_count < MAX_BLOCK_COUNT);
    assert(gb_valid_pos(block.pos));
    blocks[block_count++] = block;
}

void gb_render(void) {
    for (int i = 0; i < block_count; ++i) {
        render_block(blocks[i]);
    }
}