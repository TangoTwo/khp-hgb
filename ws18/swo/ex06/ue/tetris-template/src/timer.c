//
// Created by khp on 12.11.18.
//
#include <assert.h>
#include <stddef.h>
#include <GLFW/glfw3.h>
#include "timer.h"

static double timer_interval = 0;
static timer_func callback = NULL;

void timer_init(double  intv, timer_func on_timer){
    timer_interval = intv;
    callback = on_timer;
    timer_reset();
}

void timer_test(void) {
    assert(callback);

    if(glfwGetTime() >= timer_interval) {
        callback();
        timer_reset();
    }
}

void timer_reset(void) {
    glfwSetTime(0.0);
}