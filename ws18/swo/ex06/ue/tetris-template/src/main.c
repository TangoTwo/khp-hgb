#include <stdio.h>
#include <stdlib.h>

#define GLFW_INCLUDE_GLU

#include <GLFW/glfw3.h>
#include "gameboard.h"
#include "types.h"
#include "timer.h"

#define WIDTH  400
#define HEIGHT WIDTH * (GB_ROWS / GB_COLS)


static block current = {{GB_COLS / 2, GB_ROWS - 1}, color_red};

static bool game_over = false;

static bool try_move(int dx, int dy) {
    position pos = current.pos;
    pos.x += dx;
    pos.y += dy;
    if (!gb_valid_pos(pos))
        return false;
    current.pos = pos;
    return true;
}

static color random_color(void) {
    static color colors[] = {
            color_red,
            color_blue,
            color_cyan,
            color_green,
            color_yellow,
            color_magenta
    };

    int n_colors = sizeof(colors)/ sizeof(color);
    return colors[rand()%n_colors];
}

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
        default:
            return;
    }

    if (action == GLFW_PRESS || action == GLFW_REPEAT)
        if (!try_move(dx, dy)) {
            if (dy == -1) {
                gb_add_block(current);
                //create new block
                current.pos.x = GB_COLS / 2;
                current.pos.y = GB_ROWS - 1;
                current.color = random_color();
                if(!gb_valid_pos(current.pos)) {
                    game_over = true;
                }
            }
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
        render_block(current); //render current block

        const GLenum error = glGetError();
        if (error != GL_NO_ERROR) fprintf(stderr, "ERROR: %s\n", gluErrorString(error));


        glfwSwapBuffers(window);//push image to display
        glfwWaitEventsTimeout(timer_interval/5); //process all events of the application
    }

    glfwDestroyWindow(window);
    glfwTerminate();
    return EXIT_SUCCESS;
}
