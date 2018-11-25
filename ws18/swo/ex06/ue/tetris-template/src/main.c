#include <stdio.h>
#include <stdlib.h>

#define GLFW_INCLUDE_GLU

#include <GLFW/glfw3.h>
#include "gameboard.h"
#include "types.h"
#include "timer.h"
#include "try.h"
#include "random.h"

#define WIDTH  400
#define HEIGHT WIDTH * (GB_ROWS / GB_COLS)

static form current;

static bool game_over = false;

static void on_key(GLFWwindow *window, int key, int scancode, int action, int modifiers) {
    UNUSED(window);
    UNUSED(scancode);
    UNUSED(modifiers);

    if(game_over) return;
    int dx = 0;
    int dy = 0;
    switch (key) {
        case GLFW_KEY_DOWN:
            dy = -1;
            break;
        case GLFW_KEY_LEFT:
            dx = -1;
            break;
        case GLFW_KEY_RIGHT:
            dx = +1;
            break;
        case GLFW_KEY_UP:
            break;
        default:
            return;
    }

    if (action == GLFW_PRESS || action == GLFW_REPEAT) {
        if (!try_move(dx, dy, &current)) {
            if (dy == -1) {
                if (!gb_valid_pos(current.pos)) {
                    game_over = true;
                    return;
                }
                gb_add_form(current);
                //create new block
                current = random_form();
            }
        }
        if (key == GLFW_KEY_UP)
            try_rotate(&current);
    }
}

void on_timer(void) {
    on_key(NULL, GLFW_KEY_DOWN, 0, GLFW_PRESS, 0);
}

int main() {
    if (!glfwInit()) {
        fprintf(stderr, "could not initialize GLFW\n");
        return EXIT_FAILURE;
    }

    GLFWwindow *const window = glfwCreateWindow(WIDTH, HEIGHT, "Tetris", NULL, NULL);
    if (!window) {
        glfwTerminate();
        fprintf(stderr, "could not open window\n");
        return EXIT_FAILURE;
    }

    int width, height;
    glfwGetWindowSize(window, &width, &height);
    glfwSetWindowAspectRatio(window, width, height);//enforce correct aspect ratio
    glfwMakeContextCurrent(window);
    glfwSetKeyCallback(window, on_key);

    double timer_interval = 0.5;
    timer_init(timer_interval, on_timer);
    init_form_types();
    current = random_form();

    while (!glfwWindowShouldClose(window)) {
        timer_test();
        glfwGetFramebufferSize(window, &width, &height);
        glViewport(0, 0, width, height);
        glClear(GL_COLOR_BUFFER_BIT);//clear frame buffer
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        gluOrtho2D(0, width, 0, height); //orthogonal projection - origin is in lower-left corner
        glScalef((float) width / (float) GB_COLS, (float) height / (float) GB_ROWS,
                 1); //scale logical pixel to screen pixels

        gb_render(); //render gameboard
        render_form(current); //render current block

        const GLenum error = glGetError();
        if (error != GL_NO_ERROR) fprintf(stderr, "ERROR: %s\n", gluErrorString(error));


        glfwSwapBuffers(window);//push image to display
        glfwWaitEventsTimeout(timer_interval/5); //process all events of the application
    }

    glfwDestroyWindow(window);
    glfwTerminate();
    return EXIT_SUCCESS;
}
