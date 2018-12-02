//
// Created by khp on 12.11.18.
//

#ifndef PROJECT_TIMER_H
#define PROJECT_TIMER_H

typedef void (*timer_func)(void);
extern void timer_init(double  timer_interval, timer_func on_timer);
extern void timer_test(void);
extern void timer_reset(void);

#endif //PROJECT_TIMER_H
