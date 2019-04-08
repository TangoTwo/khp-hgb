#include "GL/freeglut.h"
#include <iostream>
using namespace std;

// GLUT Window ID
int windowid;

#define LABYRINTH_WALL_LENGTH 10
// Labyrinth matrix
bool labyrinthLayout[LABYRINTH_WALL_LENGTH][LABYRINTH_WALL_LENGTH] = {
    {1,1,1,1,1,1,1,1,1,1},
    {1,0,0,1,1,0,1,1,0,1},
    {1,1,0,0,0,0,0,0,1,1},
    {1,0,0,0,1,0,0,0,1,1},
    {1,0,1,0,1,0,1,0,1,1},
    {1,0,0,0,0,0,1,0,1,1},
    {1,0,1,0,0,1,1,0,1,1},
    {1,0,1,1,0,1,0,0,1,1},
    {1,0,1,1,0,0,0,0,1,1},
    {1,1,1,1,1,1,1,1,1,1}
};
// A rotatation matrix
GLfloat matR[][4] = {
    { 0.707, 0.707, 0.0, 0.0},
    { -0.707, 0.707, 0.0, 0.0},
    { 0.0, 0.0, 1.0, 0.0},
    { 0.0, 0.0, 0.0, 1.0}
};

// A translation matrix
GLfloat mat[][4] = {
    { 1.0, 0.0, 0.0, 0.0},
    { 0.0, 1.0, 0.0, 0.0},
    { 0.0, 0.0, 1.0, 0.0},
    { 0.5, 0.0, -1.5, 1.0}
};

// Angle for cube rotation
GLfloat angleCube = 0.0; //angle for cube1

GLfloat navX = 0.0f;
GLfloat navZ = 5.0f;

GLdouble x = 0.0f;
GLdouble y = 0.0f;
GLdouble rot = 0.0f;
/*-[Keyboard Callback]-------------------------------------------------------*/
void keyboard(unsigned char key, int x, int y) {
  switch (key) {
    case 'a': // lowercase character 'a'
      cout << "You just pressed 'a'" << endl;
      rot += 0.1;

      break;
    case 'd': // lowercase character 'd'
      cout << "You just pressed 'd'" << endl;
      rot -= 0.1;

      break;
    case 'w': // lowercase character 'w'
      cout << "You just pressed 'w'" << endl;
      x += 0.1;

      break;
    case 's': // lowercase character 's'
      cout << "You just pressed 's'" << endl;
      x -= 0.1;

      break;
    case 27: // Escape key
      glutDestroyWindow(windowid);
      exit(0);
      break;
  }
  glutPostRedisplay();
}

/*-[MouseClick Callback]-----------------------------------------------------*/
void onMouseClick(int button, int state, int x, int y) {
  if (button == GLUT_MIDDLE_BUTTON && state == GLUT_DOWN) {
    cout << "Middle button clicked at position "
         << "x: " << x << " y: " << y << endl;
  }
}

/*-[Reshape Callback]--------------------------------------------------------*/
void reshapeFunc(int x, int y) {
  if (y == 0 || x == 0) return;  //Nothing is visible then, so return

  glMatrixMode(GL_PROJECTION); //Set a new projection matrix
  glLoadIdentity();
  //Angle of view: 40 degrees
  //Near clipping plane distance: 0.5
  //Far clipping plane distance: 20.0

  gluPerspective(40.0, (GLdouble)x / (GLdouble)y, 0.5, 20.0);
  glViewport(0, 0, x, y);  //Use the whole window for rendering

}

/*-[playWithTransforms Callback]---------------------------------------------*/
void renderCube(void) {
  glMatrixMode(GL_MODELVIEW);
  glClear(GL_COLOR_BUFFER_BIT);
  glLoadIdentity();
  gluLookAt(x,0.0f,rot,2.0f,0.0f,0.0f,0.0f,1.0f,0.0f);

  for (int i = 0; i < LABYRINTH_WALL_LENGTH; ++i) {
    for (int j = 0; j < LABYRINTH_WALL_LENGTH; ++j) {
      if(labyrinthLayout[i][j]) {
        glPushMatrix();
        glColor3f(0.1, 0.2, 0.3);
        glTranslatef(i, 0.0f, -j);
        glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
        //glutSolidCube(0.99f);
        glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
        glutSolidCube(1.0f);
        glEnable(GL_DEPTH_TEST);
        glClear(GL_DEPTH_BUFFER_BIT);
        glPopMatrix();
      }
    }
  }
  glutSwapBuffers();
}

void idleFunc(void) {

}

int main(int argc, char **argv) {

  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
  glutInitWindowPosition(500, 500); //determines the initial position of the window
  glutInitWindowSize(800, 600); //determines the size of the window
  windowid = glutCreateWindow("Our Second OpenGL Window"); // create and name window
  //glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

  // register callbacks
  glutKeyboardFunc(keyboard);
  glutMouseFunc(onMouseClick);
  glutReshapeFunc(reshapeFunc);

  // ** Part 1 - we simply render primitives **
  //glutDisplayFunc(renderPrimitives);

  // ** Part 2 - we start with 3D scene setup and projections **
  //glutDisplayFunc(render3DScene);

  // ** Part 3 - we play with transformations **
  glutDisplayFunc(renderCube);

  glutIdleFunc(idleFunc);

  glutMainLoop(); // start the main loop of GLUT
  return 0;
}