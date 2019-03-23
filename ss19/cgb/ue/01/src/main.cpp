#include <utility>

#include "GL/freeglut.h"
#include <iostream>
#include <map>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

const int INITIAL_TIMEOUT_PRESENTATION = 2000;
const int TIMEOUT_KEYPRESS = 200;
const float MULTIPLIER_TIMEOUT = 0.9;
const float MULTIPLIER_COLOR = 2;
enum class ColorType { RED, GREEN, BLUE, YELLOW, NONE };
const std::map<char, ColorType> KEYMAP_COLORS = {
    {'g', ColorType::GREEN},
    {'y', ColorType::YELLOW},
    {'r', ColorType::RED},
    {'b', ColorType::BLUE}
  };

struct Sequence {
  Sequence(std::vector<ColorType> colorSequence, unsigned int displayTimeout = INITIAL_TIMEOUT_PRESENTATION) :
    colorSequence{colorSequence},
    displayTimeout{displayTimeout}
    {};
  bool isCurrentColor(ColorType color) {
    if(color == colorSequence[currentIndex]){
      currentIndex++;
      return true;
    } else {
      return false;
    }
  }
  ColorType getColor(unsigned int index) {
    displayTimeout = std::ceil(displayTimeout * MULTIPLIER_TIMEOUT);
    if(index >= colorSequence.size()) {
      return ColorType::NONE;
    }
    return colorSequence[index];
  }
  unsigned int displayTimeout = INITIAL_TIMEOUT_PRESENTATION;
 private:
  std::vector<ColorType> colorSequence;
  int currentIndex = 0;
};
float displayTimeout = INITIAL_TIMEOUT_PRESENTATION;
ColorType displayedColor = ColorType::NONE;
//std::vector<ColorType> currentSequence = {ColorType::YELLOW, ColorType::GREEN, ColorType::YELLOW, ColorType::RED};
Sequence currentSequence {{ColorType::YELLOW, ColorType::GREEN, ColorType::YELLOW, ColorType::RED}};
unsigned int playerPoints = 0;
int windowid;
void checkKey(char key);

void onMouseClick(int button, int state, int x, int y) {
  if (button == GLUT_RIGHT_BUTTON) {
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(0.0, 1.0, 0.0, 1.0);

    glutSwapBuffers();
  }
}

void keyboard(unsigned char key, int x, int y) {
  switch (key) {
    case 'r':
    case 'g':
    case 'b':
    case 'y':
      checkKey(key);
      break;
    case 27:glutDestroyMenu(windowid);
      exit(0);
    default:break;
  }
  glutPostRedisplay();
}

void switchToPlayer(int _ = 0) { //to provide interface with glutTimerFunc
  displayedColor = ColorType::NONE;
  glutMouseFunc(onMouseClick);
  glutKeyboardFunc(keyboard);
  glutPostRedisplay();
}

void checkKey(char key) {
  auto tIter = KEYMAP_COLORS.find(key);
  if(tIter == KEYMAP_COLORS.end())
    return;
  if(currentSequence.isCurrentColor(tIter->second)) {
    displayedColor = tIter->second;
    glutPostRedisplay();
    std::cout << ++playerPoints << std::endl;
    glutTimerFunc(TIMEOUT_KEYPRESS, switchToPlayer, 0);
  } else {
    // YOU FAILED, PROGRAM WILL EXIT
    exit(EXIT_SUCCESS);
  }
}

void setColorOfSequence(int index) {
  displayedColor = currentSequence.getColor(index);
  if(displayedColor == ColorType::NONE) { //end of sequence
    switchToPlayer();
    return;
  }
  glutTimerFunc(currentSequence.displayTimeout, setColorOfSequence, index + 1);
  glutPostRedisplay();
}

void playSequence() {
  glutMouseFunc([](int, int, int, int){});
  glutKeyboardFunc([](unsigned char, int, int){});
  displayedColor = currentSequence.getColor(0);
  glutTimerFunc(currentSequence.displayTimeout, setColorOfSequence, 1);
  glutPostRedisplay();
}

void startTimeout(int value) {
  glutTimerFunc(INITIAL_TIMEOUT_PRESENTATION, startTimeout, value);
}

void scissors() {
  int windowWidth = glutGet(GLUT_WINDOW_WIDTH);
  int windowHeight = glutGet(GLUT_WINDOW_HEIGHT);

  GLclampf multiplierRed = 1, multiplierGreen = 1, multiplierBlue = 1, multiplierYellow = 1;
  switch (displayedColor) {
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
    default:break;
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

void renderScene() {
  glClear(GL_COLOR_BUFFER_BIT);
  glClearColor(1.0, 1.0, 0.0, 1.0);
  scissors();
  glutSwapBuffers();
}
void bored() {
  cout << "I'm bored" << endl;
}
int main(int argc, char **argv) {
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
  glutInitWindowPosition(500, 500);
  glutInitWindowSize(800, 600);
  //initColor();
  windowid = glutCreateWindow(
      "Simon - The Game by S1720307111 (Konstantin Papesh, s1720307111), SE Bachelor 2017 Fulltime "
      "FH Upper Austria - Campus Hagenberg, CGB4 - Group 1 - Exercise 1");
  glutDisplayFunc(renderScene);
  //glutIdleFunc(bored);
  playSequence();
  //startTimeout(0);
  glutMainLoop();
  return 0;
}