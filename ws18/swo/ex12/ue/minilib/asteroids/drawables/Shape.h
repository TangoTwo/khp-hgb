//
// Created by khp on 16.03.19.
//

#ifndef EX01_DRAWABLE_H
#define EX01_DRAWABLE_H

#include <ml5/ml5.h>

class Shape : public ml5::object, MI5_DERIVE(Shape, ml5::object) {
 MI5_INJECT(Shape)
public:
  virtual void draw(ml5::paint_event::context_t &context) const {
    context.SetPen(_pen);
    context.SetBrush(_brush);
    doDraw(context);
  }
  virtual void updatePos() {
    _position += _movement;
  }
  virtual bool isCollideable() const {
   return _collideable;
 }

protected:
  virtual void doDraw(ml5::paint_event::context_t &context) const = 0;

  wxPen _pen{*wxBLACK_PEN};
  wxBrush _brush{*wxTRANSPARENT_BRUSH};
  wxPoint _position{100, 100};
  wxPoint _movement{0, 0};
  double _rotation{0};
  bool _collideable = true;
};

#endif //EX01_DRAWABLE_H
