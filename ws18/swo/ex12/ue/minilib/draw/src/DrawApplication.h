//
// Created by root on 1/21/19.
//

#ifndef PROJECT_DRAWAPPLICATION_H
#define PROJECT_DRAWAPPLICATION_H


#include <ml5/ml5.h>
#include "DrawWindow.h"

class DrawApplication : public ml5::application, MI5_DERIVE(DrawApplication, ml5::application) {
MI5_INJECT(DrawApplication)
private:
    std::unique_ptr<ml5::window> make_window() const override {
        return std::make_unique<DrawWindow>();
    }
};


#endif //PROJECT_DRAWAPPLICATION_H
