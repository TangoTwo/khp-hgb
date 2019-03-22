//
// Created by khp on 17.03.19.
//

#ifndef EX01_ASTEROID_H
#define EX01_ASTEROID_H

#include <list>
#include <random>
#include "Shape.h"

#define INITIAL_ASTEROID_SIZE 20

class Asteroid : public Shape, MI5_DERIVE(Asteroid, Shape) {
 MI5_INJECT(Asteroid)
 public:
  Asteroid(wxPoint _position, wxPoint _movement, std::vector<Shape>& _gameShapes, int size = INITIAL_ASTEROID_SIZE)
    : _gameShapes{_gameShapes} {
    _createAsteroid(size);
    this->_position = _position;
    this->_movement = _movement;
  };
  void updatePos() override {
    _position += _movement;
    _checkForCollisions();
  }
 protected:
  void doDraw(ml5::paint_event::context_t &context) const override {
    for (int i = 0; i < _shape.size()-1; ++i) {
      context.DrawLine(_position + _shape[i], _position + _shape[i+1]);
    }
    context.DrawLine(_position + _shape[_shape.size()-1], _position + _shape[0]);
  }
 private:
  void _createAsteroid(int size) {
    std::random_device generator;
    std::uniform_int_distribution<int> distribution(-(size/2), size/2);

    //right side
    _shape.emplace_back(wxPoint(-(size/2) + distribution(generator), size + distribution(generator)));
    _shape.emplace_back(wxPoint(0 + distribution(generator), size + distribution(generator)));
    _shape.emplace_back(wxPoint((size/2) + distribution(generator), size + distribution(generator)));


    //upper side
    _shape.emplace_back(wxPoint(size + distribution(generator), (size/2) + distribution(generator)));
    _shape.emplace_back(wxPoint(size + distribution(generator), 0 + distribution(generator)));
    _shape.emplace_back(wxPoint(size + distribution(generator), -(size/2) + distribution(generator)));

    //left side
    _shape.emplace_back(wxPoint((size/2) + distribution(generator), -size + distribution(generator)));
    _shape.emplace_back(wxPoint(0 + distribution(generator), -size + distribution(generator)));
    _shape.emplace_back(wxPoint(-(size/2) + distribution(generator), -size + distribution(generator)));

    //lower side
    _shape.emplace_back(wxPoint(-size + distribution(generator), -(size/2) + distribution(generator)));
    _shape.emplace_back(wxPoint(-size + distribution(generator), 0 + distribution(generator)));
    _shape.emplace_back(-size + distribution(generator), (size/2) + distribution(generator));
  }
  void _checkForCollisions() {
    for (const auto &gameShape : _gameShapes) {
      if(!gameShape.is_a("Asteroid") && gameShape.isCollideable()) {
        //Split Asteroid
      }
    }
  }
  std::vector<wxPoint> _shape{};
  std::vector<Shape>& _gameShapes;
};

#endif //EX01_ASTEROID_H
