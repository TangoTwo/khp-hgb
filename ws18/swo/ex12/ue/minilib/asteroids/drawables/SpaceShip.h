//
// Created by khp on 16.03.19.
//

#ifndef EX01_SPACESHIP_H
#define EX01_SPACESHIP_H

#include <ml5/ml5.h>
#include "Shape.h"
#include "Laser.h"

#define DECEL_MULTIPLIER 0.999
#define MAX_SPEED 11
#define ACCELERATION 5
#define ROTATION_ADDED 0.1

class SpaceShip : public Shape, MI5_DERIVE(SpaceShip, Shape) {
 MI5_INJECT(SpaceShip)
public:
  enum class Rotate{left, right};
  SpaceShip(std::vector<Shape>& _gameShapes)  : _gameShapes{_gameShapes} {
    _image.LoadFile("images/ship.png", wxBITMAP_TYPE_PNG);
    _image = _image.Scale(round(_image.GetWidth()*0.1), round(_image.GetHeight()*0.1));
  }

  void updatePos() override {
    _movement = _movement * DECEL_MULTIPLIER;
    _position += _movement;
  }

  void accelerate() {
    if(sqrt(_movement.x^2 + _movement.y^2) > MAX_SPEED)
      return;

    _movement.x += ACCELERATION * cos(_rotation);
    _movement.y -= ACCELERATION * sin(_rotation);
  };

  void fire() {
    _gameShapes.push_back(Laser(_position, _movement));
  }
  void rotate(Rotate direction) {
    if(direction == Rotate::right) {
      _rotation -= ROTATION_ADDED;
    } else {
      _rotation += ROTATION_ADDED;
    }
  }

protected:
  void doDraw(ml5::paint_event::context_t &context) const override {
    auto tImage = _image.Rotate(_rotation, wxPoint(_image.GetWidth()/2, _image.GetHeight()/2));
    context.DrawBitmap(tImage, wxPoint(_position.x - tImage.GetWidth()/2, _position.y - tImage.GetHeight()/2));
  }
private:
  wxImage _image;
  std::vector<Shape>& _gameShapes;
};

#endif //EX01_SPACESHIP_H
