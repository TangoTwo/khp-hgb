//
// Created by khp on 27.01.19.
//

#ifndef PROJECT_ELLIPSE_H
#define PROJECT_ELLIPSE_H

#include <ml5/ml5.h>
#include "Shape.h"

class Ellipse : public Shape, MI5_DERIVE(Ellipse, Shape) {
MI5_INJECT(Ellipse)
public:
    Ellipse(const wxRect &box, const wxPen &pen, const wxBrush &brush)
            : Shape{box, pen, brush} {
        _name = "Ellipse";
    };

    Ellipse(const Ellipse &other) : Shape{other._box, other._pen, other._brush} {
        _name = other._name;
    };

    std::unique_ptr<Shape> clone() const override {
        return std::make_unique<Ellipse>(*this);
    };

private:
    void doDraw(context_t &context) const override {
        context.DrawEllipse(_box);
    }

    void doDrawIcon(const int offset, context_t &context) const override {
        wxRect _icon{};
        _icon.SetLeftTop(wxPoint(25, offset + 5));
        _icon.SetRightBottom(wxPoint(5, offset + 25));
        context.DrawEllipse(_icon);
    }
};


#endif //PROJECT_ELLIPSE_H
