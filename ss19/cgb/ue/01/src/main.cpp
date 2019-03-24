#include <utility>

#include "GL/freeglut.h"
#include <iostream>
#include <map>
#include <vector>
#include <algorithm>
#include <cmath>
#include <random>

using namespace std;

const int INITIAL_TIMEOUT_PRESENTATION = 2000;
const int TIMEOUT_KEYPRESS = 200;
const int MAX_WRONG_CLICKS = 3;
const int GENERATED_LEVELS = 3;
const float MULTIPLIER_TIMEOUT = 0.9;
const float MULTIPLIER_COLOR = 2;
enum ColorType { RED, GREEN, BLUE, YELLOW, NONE };
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
    if(color == colorSequence[currentSelectionIndex]){
      currentSelectionIndex++;
      return true;
    } else {
      return false;
    }
  }
  bool isAtEnd() {
    return currentSelectionIndex == colorSequence.size();
  }
  ColorType getColor(unsigned int index) {
    displayTimeout = std::ceil(displayTimeout * MULTIPLIER_TIMEOUT); //to speed up sequence --> harder
    if(index >= colorSequence.size()) {
      return ColorType::NONE;
    }
    return colorSequence[index];
  }
  unsigned int displayTimeout = INITIAL_TIMEOUT_PRESENTATION;
 private:
  std::vector<ColorType> colorSequence;
  int currentSelectionIndex = 0;
};


ColorType displayedColor = ColorType::NONE;
Sequence seqFirstLevel {{ColorType::YELLOW, ColorType::BLUE, ColorType::YELLOW, ColorType::RED}};
Sequence seqSecondLevel {{ColorType::YELLOW, ColorType::GREEN, ColorType::YELLOW, ColorType::RED}, (unsigned int)(INITIAL_TIMEOUT_PRESENTATION * 0.7)};
Sequence seqThirdLevel {{ColorType::YELLOW, ColorType::GREEN, ColorType::YELLOW, ColorType::RED}, (unsigned int)(INITIAL_TIMEOUT_PRESENTATION * 0.7)};
std::vector<Sequence> sequenceVector {
    std::move(seqFirstLevel),
    std::move(seqSecondLevel),
    std::move(seqThirdLevel)
};
unsigned int currentLevel{0};
Sequence& currentSequence {sequenceVector[currentLevel]};
int playerPoints = 0;
int windowid;
int wrongClicks = 0;

void playSequence();
void checkKey(char);
void switchToPlayer(int);


void checkCorrectColor(ColorType color) {
  displayedColor = color;
  glutPostRedisplay();
  if(currentSequence.isCurrentColor(color)) {
    displayedColor = color;
    glutPostRedisplay();
    std::cout << ++playerPoints << std::endl;
    if(currentSequence.isAtEnd()) {
      try {
        currentSequence = sequenceVector.at(++currentLevel);
      } catch (exception& excpt) {
        std::cout << "Out of pre-generated sequecences! Thanks for playing!" << std::endl;
        std::cout << "Your final score was: " << playerPoints << std::endl;
        exit(EXIT_SUCCESS);
      }
      playSequence();
    } else {
      glutTimerFunc(TIMEOUT_KEYPRESS, switchToPlayer, 0);
    }
  } else {
    wrongClicks++;
    playerPoints--;
    glutTimerFunc(TIMEOUT_KEYPRESS, switchToPlayer, 0);
    if(wrongClicks >= MAX_WRONG_CLICKS) {
      std::cout << "That's one too many. Sorry, you're out of the game!" << std::endl;
      std::cout << "Your final score was: " << playerPoints << std::endl;
      exit(EXIT_SUCCESS);
    }
  }
}

void onMouseClick(int button, int state, int x, int y) {
  if (button == GLUT_LEFT_BUTTON && state == GLUT_DOWN) {
    int windowWidth = glutGet(GLUT_WINDOW_WIDTH);
    int windowHeight = glutGet(GLUT_WINDOW_HEIGHT);
    if(x < windowWidth/2 && y < windowHeight/2) { //first area --> red
      checkCorrectColor(ColorType::RED);
    } else if (x > windowWidth/2 && y < windowHeight/2) { //second area --> green
      checkCorrectColor(ColorType::GREEN);
    } else if (x < windowWidth/2 && y > windowHeight/2) { //third area --> blue
      checkCorrectColor(ColorType::BLUE);
    } else {    //fourth area --> yellow
      checkCorrectColor(ColorType::YELLOW);
    }
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
  checkCorrectColor(tIter->second);
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

void generateLevels() {
  std::random_device generator;
  std::uniform_int_distribution<int> distribution(0, ColorType::NONE - 1);

  sequenceVector.clear(); // clear pre-generated vector
  ColorType lastColor;
  ColorType currentColor = {ColorType::NONE};
  for (int i = 0; i < GENERATED_LEVELS; ++i) {
    std::vector<ColorType> tSeqenceVector;
    int sequenceLength = i * 4 + 2;
    for (int j = 0; j < sequenceLength; ++j) {
      lastColor = currentColor;
      do {
        currentColor = ColorType(distribution(generator));
      } while(currentColor == lastColor); // so there's never the same color twice
      tSeqenceVector.push_back(currentColor);
    }
    Sequence tSequence {tSeqenceVector, (unsigned int)(INITIAL_TIMEOUT_PRESENTATION * 1 / (i + 1))};
    sequenceVector.push_back(tSequence);
  }
  currentSequence = sequenceVector.at(currentLevel);
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

void openSelectionScreen(int argc, char* argv[]) {
  char selection;
  bool validSelection = false;
  std::cout << "Simon - The Game" << std::endl;
  std::cout << "Created 2019 by Konstantin Papesh" << std::endl;
  std::cout << std::endl;
  do {
    std::cout << "Enter (1) to enter random mode or (2) to enter predefined mode." << std::endl;
    std::cin >> selection;
    if (selection == '1') {
      generateLevels();
      validSelection = true;
    } else if (selection == '2') {
      //LEAVE LEVELS UNCHANGED
      validSelection = true;
    } else {
      std::cout << "\033c"; //CLEARS CONSOLE
      std::cout << "No valid selection... try again." << std::endl;
    }
  } while (!validSelection);
  std::cout << "\033c";
}

int main(int argc, char **argv) {
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
  glutInitWindowPosition(500, 500);
  glutInitWindowSize(800, 600);
  openSelectionScreen(argc, argv);
  windowid = glutCreateWindow(
      "Simon - The Game by S1720307111 (Konstantin Papesh, s1720307111), SE Bachelor 2017 Fulltime "
      "FH Upper Austria - Campus Hagenberg, CGB4 - Group 1 - Exercise 1");
  glutDisplayFunc(renderScene);
  playSequence();
  glutMainLoop();
  return 0;
}