/* prg.c */

#include <stdio.h>
#include "geo.h"
#include "weight.h"

int main() {
  double v = box_volume(24.5, 6.9, 3.7);
  printf("Volumen Goldbarren=%.2f cm3\n", v);
  
  double w = box_weight(24.5, 6.9, 3.7, 19.33);
  printf("Gewicht Goldbarren=%.2f kg\n", w/1000.0);
  return 0;
}

