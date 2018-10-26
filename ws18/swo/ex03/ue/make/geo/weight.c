/* weight.c */

#include "geo.h"
#include "weight.h"

double box_weight(double a, double b, double h, double sw) {
   return box_volume(a, b, h) * sw;
}