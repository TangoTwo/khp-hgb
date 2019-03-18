//
// Created by root on 1/21/19.
//

#ifndef PROJECT_DRAWWINDOW_H
#define PROJECT_DRAWWINDOW_H

#include <vector>
#include <ml5/ml5.h>
#include "drawables/spaceShip.h"
#include "drawables/asteroid.h"

SpaceShip* spaceShip;

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
    wxImage::AddHandler(new wxPNGHandler);
    spaceShip = new SpaceShip;
    start_timer(std::chrono::milliseconds(40));
  }

  void on_key(ml5::key_event const & event) override{
   int tKey = event.get_key_code();
   if(tKey == 315) { //up
     spaceShip->accelerate();
   } else if(tKey == 314) { //left
     spaceShip->rotate(SpaceShip::Rotate::left);
   } else if(tKey == 316) { //right
     spaceShip->rotate(SpaceShip::Rotate::right);
   }
 }

  void on_timer(ml5::timer_event const & event) override {
    spaceShip->updatePos();
    refresh();
  }

  void on_paint(ml5::paint_event const &event) override {
    Asteroid asteroid{wxPoint(500, 500), wxPoint(0,0)};
    asteroid.draw(event.get_context());
    spaceShip->draw(event.get_context());
  }
};

#endif //PROJECT_DRAWWINDOW_H
