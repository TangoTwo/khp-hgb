//
// Created by khp on 24.11.18.
//

#include "try.h"
#include "types.h"
#include "gameboard.h"

extern bool try_move(int dx, int dy, form *current) {
    position future_pos = current->pos;
    future_pos.x += dx;
    future_pos.y += dy;
    for (int i = 0; i < BLOCKS_IN_FORM; ++i) {
        position t_pos = future_pos;
        t_pos.x = future_pos.x + current->form_type.blocks[i].pos.x;
        t_pos.y = future_pos.y + current->form_type.blocks[i].pos.y;
        if (!gb_valid_pos(t_pos))
            return false;
    }
    current->pos = future_pos;
    return true;
}

extern bool try_rotate(form *current) {
    form t_form = *current;
    t_form.form_type = rotate_form_type(current->form_type);
    for (int i = 0; i < BLOCKS_IN_FORM; ++i) {
        position t_pos = t_form.pos;
        t_pos.x = t_pos.x + t_form.form_type.blocks[i].pos.x;
        t_pos.y = t_pos.y + t_form.form_type.blocks[i].pos.y;
        if (!gb_valid_pos(t_pos))
            return false;
    }
    *current = t_form;
    return true;
}