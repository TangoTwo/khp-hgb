#include <GLFW/glfw3.h>
#include "types.h"



void init_form_types() {
	// I
	form_types[0].blocks[0].pos.x = 0;
	form_types[0].blocks[0].pos.y = -1;

	form_types[0].blocks[1].pos.x = 0;
	form_types[0].blocks[1].pos.y = 0;

	form_types[0].blocks[2].pos.x = 0;
	form_types[0].blocks[2].pos.y = 1;

	form_types[0].blocks[3].pos.x = 0;
	form_types[0].blocks[3].pos.y = 2;

	// J
	form_types[1].blocks[0].pos.x = 0;
	form_types[1].blocks[0].pos.y = -1;

	form_types[1].blocks[1].pos.x = 0;
	form_types[1].blocks[1].pos.y = 0;

	form_types[1].blocks[2].pos.x = 0;
	form_types[1].blocks[2].pos.y = 1;

	form_types[1].blocks[3].pos.x = -1;
	form_types[1].blocks[3].pos.y = 1;

    // L
    form_types[2].blocks[0].pos.x = 0;
    form_types[2].blocks[0].pos.y = -1;

    form_types[2].blocks[1].pos.x = 0;
    form_types[2].blocks[1].pos.y = 0;

    form_types[2].blocks[2].pos.x = 0;
    form_types[2].blocks[2].pos.y = 1;

    form_types[2].blocks[3].pos.x = 1;
    form_types[2].blocks[3].pos.y = 1;

	// Z
	form_types[3].blocks[0].pos.x = 0;
	form_types[3].blocks[0].pos.y = -1;

	form_types[3].blocks[1].pos.x = 1;
	form_types[3].blocks[1].pos.y = -1;

	form_types[3].blocks[2].pos.x = 1;
	form_types[3].blocks[2].pos.y = 0;

	form_types[3].blocks[3].pos.x = 0;
	form_types[3].blocks[3].pos.y = -2;

	// S
	form_types[4].blocks[0].pos.x = 0;
	form_types[4].blocks[0].pos.y = -1;

	form_types[4].blocks[1].pos.x = 0;
	form_types[4].blocks[1].pos.y = 0;

	form_types[4].blocks[2].pos.x = 1;
	form_types[4].blocks[2].pos.y = -1;

	form_types[4].blocks[3].pos.x = 1;
	form_types[4].blocks[3].pos.y = -2;

	// T
	form_types[5].blocks[0].pos.x = -1;
	form_types[5].blocks[0].pos.y = 0;

	form_types[5].blocks[1].pos.x = 0;
	form_types[5].blocks[1].pos.y = 0;

	form_types[5].blocks[2].pos.x = 1;
	form_types[5].blocks[2].pos.y = 0;

	form_types[5].blocks[3].pos.x = 0;
	form_types[5].blocks[3].pos.y = 1;

	// O
	form_types[6].blocks[0].pos.x = 0;
	form_types[6].blocks[0].pos.y = 0;

	form_types[6].blocks[1].pos.x = 1;
	form_types[6].blocks[1].pos.y = 0;

	form_types[6].blocks[2].pos.x = 0;
	form_types[6].blocks[2].pos.y = 1;

	form_types[6].blocks[3].pos.x = 1;
	form_types[6].blocks[3].pos.y = 1;
}

form_type rotate_form_type(form_type original_form) {
    form_type res_form = original_form;
    for (int i = 0; i < BLOCKS_IN_FORM; ++i) {
        res_form.blocks[i].pos.y = -original_form.blocks[i].pos.x;
        res_form.blocks[i].pos.x = original_form.blocks[i].pos.y;
    }
	return res_form;
}

void render_quad(const position pos, const color color) {
	static_assert(sizeof(color) == 4, "detected unexpected size for colors");
	glColor3ubv((unsigned char *)&color);
	glBegin(GL_QUADS); {
		glVertex2i(pos.x,     pos.y);
		glVertex2i(pos.x,     pos.y + 1);
		glVertex2i(pos.x + 1, pos.y + 1);
		glVertex2i(pos.x + 1, pos.y);
	} glEnd();
}

void render_block(const block block) {
	render_quad(block.pos, block.color);
}

void render_form(const form form) {
    for (int i = 0; i < BLOCKS_IN_FORM; ++i) {
		block block;
		block.color = form.color;
		block.pos.x = form.pos.x + form.form_type.blocks[i].pos.x;
		block.pos.y = form.pos.y + form.form_type.blocks[i].pos.y;
        render_block(block);
    }
}