//
// Created by khp on 19.03.19.
//

#ifndef EX01_LASER_H
#define EX01_LASER_H

#include "Shape.h"

class Laser : public Shape{
 public:
  Laser(wxPoint _position, wxPoint _movement) {
    this->_position = _position;
    this->_movement = _movement;
  }
 protected:
  void doDraw(ml5::paint_event::context_t &context) const override {
    context.DrawLine(_position + _movement * 10, _position - _movement * 10);
  }
};

#endif //EX01_LASER_H
