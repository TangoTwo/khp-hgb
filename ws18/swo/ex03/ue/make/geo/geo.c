/* geo.c */

#include "geo.h"

double rectangle_area(double a, double b) {
  return a*b;
}

double box_volume(double a, double b, double h) {
  return rectangle_area(a, b) * h;
}