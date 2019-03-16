//
// Created by root on 1/21/19.
//

#ifndef PROJECT_DRAWWINDOW_H
#define PROJECT_DRAWWINDOW_H

#include <vector>
#include <ml5/ml5.h>

class DrawWindow : public ml5::window, MI5_DERIVE(DrawWindow, ml5::window) {
 MI5_INJECT(DrawWindow)
 private:
  static wxPen getDefaultPen() {
    return *wxBLACK_PEN;
  }

  static wxBrush getDefaultBrush() {
    return *wxTRANSPARENT_BRUSH;
  }

  void on_init() override {
    get_frame().SetTitle("Draw");

    mitem_cont_t tItems = {};

    tItems.push_back(std::tuple<std::string, std::string>{"&Cut", "Cut"});
    tItems.push_back(std::tuple<std::string, std::string>{"&Copy", "Copy"});
    tItems.push_back(std::tuple<std::string, std::string>{"&Paste", "Paste"});
    add_menu("&Edit", tItems);

    tItems.clear();
    add_menu("&Shape", tItems);

    //add_menu("&Width", tItems);
  }

  void on_paint(const ml5::paint_event &event) override {
  }
};

#endif //PROJECT_DRAWWINDOW_H
