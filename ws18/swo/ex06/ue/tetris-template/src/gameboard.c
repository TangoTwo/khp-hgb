#include <stddef.h>
#include <assert.h>
#include <stdlib.h>
#include "gameboard.h"

#define MAX_BLOCK_COUNT 1000

static size_t block_count = 0;
static block blocks[MAX_BLOCK_COUNT];


bool gb_valid_pos(const position pos) {
    if (!(0 <= pos.x && pos.x < GB_COLS &&
        0 <= pos.y))
        return false;
    for (int i = 0; i < block_count; ++i) {
        position p = blocks[i].pos;
        if (p.x == pos.x && p.y == pos.y)
            return false;
    }
    return true;
}

void gb_remove_row(int row) {
    unsigned long int removedBlocks = 0;
    for (int i = 0; i < block_count; ++i) {
        if(blocks[i].pos.y == row) {
            removedBlocks++;
        } else {
            if(blocks[i].pos.y > row) {
                blocks[i].pos.y--;
            }
            blocks[i - removedBlocks] = blocks[i];
        }
    }
    block_count -= removedBlocks;
}

void gb_remove_completed_rows() {
    int rowArr[GB_ROWS];
    int removedRows = 0;
    for (int j = 0; j < GB_ROWS; ++j) {
        rowArr[j] = 0;
    }
    for (int i = 0; i < block_count; ++i) {
        rowArr[blocks[i].pos.y] += 1;
    }
    for (int k = 0; k < GB_ROWS; ++k) {
        if(rowArr[k] == GB_COLS) {
            gb_remove_row(k-removedRows);
            removedRows++;
        }
    }
}

void gb_add_block(const block block) {
    assert(block_count < MAX_BLOCK_COUNT);
    assert(gb_valid_pos(block.pos));
    blocks[block_count++] = block;
}

void gb_add_form(const form form) {
    for (int i = 0; i < BLOCKS_IN_FORM; ++i) {
        block block;
        block.color = form.color;
        block.pos.x = form.pos.x + form.form_type.blocks[i].pos.x;
        block.pos.y = form.pos.y + form.form_type.blocks[i].pos.y;
        gb_add_block(block);
    }
    gb_remove_completed_rows();
}

void gb_render(void) {
    for (int i = 0; i < block_count; ++i) {
        render_block(blocks[i]);
    }
}