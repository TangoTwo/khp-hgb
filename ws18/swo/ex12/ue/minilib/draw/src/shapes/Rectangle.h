//
// Created by khp on 27.01.19.
//

#ifndef PROJECT_RECTANGLE_H
#define PROJECT_RECTANGLE_H

#include <ml5/ml5.h>
#include "Shape.h"

class Rectangle : public Shape, MI5_DERIVE(Rectangle, Shape) {
MI5_INJECT(Rectangle)
public:
    Rectangle(const wxRect &box, const wxPen &pen, const wxBrush &brush)
            : Shape{box, pen, brush} {
        _name = "Rectangle";
    };

    Rectangle(const Rectangle &other) : Shape{other._box, other._pen, other._brush} {
        _name = other._name;
    };

    std::unique_ptr<Shape> clone() const override {
        return std::make_unique<Rectangle>(*this);
    };

private:
    void doDraw(context_t &context) const override {
        context.DrawRectangle(_box);
    }

    void doDrawIcon(const int offset, context_t &context) const override {
        wxRect _icon{};
        _icon.SetLeftTop(wxPoint(25, offset + 5));
        _icon.SetRightBottom(wxPoint(5, offset + 25));
        context.DrawRectangle(_icon);
    }
};


#endif //PROJECT_RECTANGLE_H
