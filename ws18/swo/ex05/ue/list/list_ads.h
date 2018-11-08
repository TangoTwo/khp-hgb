//
// Created by khp on 05.11.18.
//

#ifndef PROJECT_LIST_ADS_H
#define PROJECT_LIST_ADS_H

typedef void (*funcT)(int);

void init(void);
void prepend(int);
void print(void);
void forEach(funcT);
void destroy(void);

#endif //PROJECT_LIST_ADS_H
