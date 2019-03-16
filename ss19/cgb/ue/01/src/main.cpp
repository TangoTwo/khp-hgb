#include <utility>

#include "GL/freeglut.h"
#include <iostream>

using namespace std;

const int INITIAL_TIMEOUT = 5000;
const float MULTIPLIER_TIMEOUT = 0.8;
const float MULTIPLIER_COLOR = 2;
enum class ColorType{RED, GREEN, BLUE, YELLOW};
bool LIT_UP = true;
int windowid;

struct Color {
    Color() = delete;
    explicit Color(std::string name, char key, GLclampf red,  GLclampf green,  GLclampf blue,  GLclampf alpha) :
        name{std::move(name)},
        key{key},
        red{red},
        green{green},
        blue{blue},
        alpha{alpha} {};
    std::string name{""};
    char key;
    GLclampf red;
    GLclampf green;
    GLclampf blue;
    GLclampf alpha;
};

void colorInit() {

}

void startTimeout(int value) {
    glutTimerFunc(INITIAL_TIMEOUT, startTimeout, value);
}

void scissors() {
    int windowWidth = glutGet(GLUT_WINDOW_WIDTH);
    int windowHeight = glutGet(GLUT_WINDOW_HEIGHT);

    ColorType currentColor = ColorType::GREEN;
    GLclampf multiplierRed = 1, multiplierGreen = 1, multiplierBlue = 1, multiplierYellow = 1;
    switch(currentColor) {
        case ColorType::RED:
            multiplierRed = MULTIPLIER_COLOR;
            break;
        case ColorType::GREEN:
            multiplierGreen = MULTIPLIER_COLOR;
            break;
        case ColorType::BLUE:
            multiplierBlue = MULTIPLIER_COLOR;
            break;
        case ColorType::YELLOW:
            multiplierYellow = MULTIPLIER_COLOR;
            break;
        default:
            break;
    }
    // #1, red
    glScissor(0, windowHeight / 2, windowWidth / 2, windowHeight / 2);
    glEnable(GL_SCISSOR_TEST);
    glClearColor(0.5 * multiplierRed, 0, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glDisable(GL_SCISSOR_TEST);
    glClearColor(0.0, 0.0, 0.0, 1.0);

    // #2, green
    glScissor(windowWidth / 2, windowHeight / 2, windowWidth / 2, windowHeight / 2);
    glEnable(GL_SCISSOR_TEST);
    glClearColor(0, 0.5 * multiplierGreen, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glDisable(GL_SCISSOR_TEST);
    glClearColor(0.0, 0.0, 0.0, 1.0);

    // #3, blue
    glScissor(0, 0, windowWidth / 2, windowHeight / 2);
    glEnable(GL_SCISSOR_TEST);
    glClearColor(0, 0, 0.3 * multiplierBlue, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glDisable(GL_SCISSOR_TEST);
    glClearColor(0.0, 0.0, 0.0, 1.0);

    // #4, yellow
    glScissor(windowWidth / 2, 0, windowWidth / 2, windowHeight / 2);
    glEnable(GL_SCISSOR_TEST);
    glClearColor(0.5 * multiplierYellow, 0.5 * multiplierYellow, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glDisable(GL_SCISSOR_TEST);
    glClearColor(0.0, 0.0, 0.0, 1.0);
}
void onMouseClick(int button, int state, int x, int y) {
    if (button == GLUT_RIGHT_BUTTON) {
        glClear(GL_COLOR_BUFFER_BIT);
        glClearColor(0.0, 1.0, 0.0, 1.0);

        glutSwapBuffers();
    }
}
void keyboard(unsigned char key, int x, int y) {
    switch (key)
    {
        case 'a':
            cout << "You just pressed 'a' with mouse at (" << x << ", " << y << ")" << endl;
            break;
        case 27:
            glutDestroyMenu(windowid);
            exit(0);
            break;
        case 32:
            glClear(GL_COLOR_BUFFER_BIT);
            glClearColor(0.0, 1.0, 1.0, 1.0);

            glutSwapBuffers();
            break;
        case 'g':
            glClear(GL_COLOR_BUFFER_BIT);
            glClearColor(0.0, 1.0, 0.0, 1.0);

            glutSwapBuffers();
            break;
        default:
            break;
    }
    glutPostRedisplay();
}
void renderScene(void) {
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(1.0, 1.0, 0.0, 1.0);
    scissors();
    glutSwapBuffers();
}
void bored(void) {
    cout << "I'm bored" << endl;
}
int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
    glutInitWindowPosition(500, 500);
    glutInitWindowSize(800, 600);
    //initColor();
    windowid = glutCreateWindow("Simon - The Game by S1720307111 (Konstantin Papesh), SE Bachelor 2017 FH Upper Austria - Campus Hagenberg, CGB4 - Group 1 - Exercise 1 - Aufgabe 1");
    glutDisplayFunc(renderScene);
    glutMouseFunc(onMouseClick);
    glutKeyboardFunc(keyboard);
    //glutIdleFunc(bored);
    startTimeout(0);
    glutMainLoop();
    return 0;
}