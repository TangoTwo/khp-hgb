//
// Created by khp on 24.11.18.
//
#include <stdlib.h>
#include <time.h>

#include "random.h"
#include "types.h"
#include "gameboard.h"

color random_color(void) {
    static color colors[] = {
            color_red,
            color_blue,
            color_cyan,
            color_green,
            color_yellow,
            color_magenta
    };

    int n_colors = sizeof(colors)/ sizeof(color);
    srand(time(NULL));
    return colors[rand()%n_colors];
}

form random_form(void) {
    form t_form;
    t_form.pos.x = GB_COLS / 2;
    t_form.pos.y = GB_ROWS - 1;
    t_form.color = random_color();
    t_form.form_type = form_types[rand()%AMOUNT_FORMS];
    return t_form;
}