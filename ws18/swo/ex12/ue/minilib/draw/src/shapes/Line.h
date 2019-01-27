//
// Created by khp on 27.01.19.
//

#ifndef PROJECT_LINE_H
#define PROJECT_LINE_H

#include <ml5/ml5.h>
#include "Shape.h"

class Line : public Shape, MI5_DERIVE(Line, Shape) {
MI5_INJECT(Line)
public:
    Line(const wxRect &box, const wxPen &pen, const wxBrush &brush)
            : Shape{box, pen, brush} {
        _name = "Line";
    };

    Line(const Line &other) : Shape{other._box, other._pen, other._brush} {
        _name = other._name;
    };

    std::unique_ptr<Shape> clone() const override {
        return std::make_unique<Line>(*this);
    };

private:
    void doDraw(context_t &context) const override {
        context.DrawLine(_box.GetLeftTop(), _box.GetRightBottom());
    }

    void doDrawIcon(const int offset, context_t &context) const override {
        wxRect _icon{};
        _icon.SetLeftTop(wxPoint(25, offset + 5));
        _icon.SetRightBottom(wxPoint(5, offset + 25));
        context.DrawLine(_icon.GetLeftTop(), _icon.GetRightBottom());
    }
};


#endif //PROJECT_LINE_H
