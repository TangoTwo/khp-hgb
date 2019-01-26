//
// Created by root on 1/21/19.
//

#ifndef PROJECT_SHAPE_H
#define PROJECT_SHAPE_H

#include <ml5/ml5.h>

class Shape : public ml5::object, MI5_DERIVE(Shape, ml5::object) {
MI5_INJECT(Shape)
public:
    using context_t = ml5::paint_event::context_t;

    explicit Shape(const wxRect &box, const wxPen &pen, const wxBrush &brush)
            : _box{box}, _pen{pen}, _brush{brush} {}


    virtual std::string getName() {
        return _name;
    };

    virtual void setBottomRight(wxPoint pos) {
        _box.SetBottomRight(pos);
    }

    virtual void setTopLeft(wxPoint pos) {
        _box.SetTopLeft(pos);
    }

    virtual bool empty() const {
        return _box.GetWidth() == 0 && _box.GetHeight() == 0;
    }

    virtual std::unique_ptr<Shape> clone() const = 0;

    virtual void draw(context_t &context) const {
        context.SetPen(_pen);
        context.SetBrush(_brush);
        doDraw(context);
    }

    virtual void drawIcon(int offset, context_t &context) const {
        doDrawIcon(offset, context);
    }

    virtual void drawBoundingBox(context_t &context) const {
        wxPen bakPen = context.GetPen();
        wxBrush bakBrush = context.GetBrush();

        wxBrush tBrush = *wxBLUE_BRUSH;
        tBrush.SetStyle(wxBRUSHSTYLE_CROSSDIAG_HATCH);
        context.SetPen(*wxBLACK_DASHED_PEN);
        context.SetBrush(tBrush);
        context.DrawRectangle(_box);

        context.SetPen(bakPen);
        context.SetBrush(bakBrush);
    }

    virtual void copyValues(const Shape &other) {
        this->_box = other._box;
        this->_pen = other._pen;
        this->_brush = other._brush;
    }

    virtual bool clickedOn(const wxPoint &pos) {
        int maxX = std::max(_box.GetLeftTop().x, _box.GetRightBottom().x);
        int minX = std::min(_box.GetLeftTop().x, _box.GetRightBottom().x);
        int maxY = std::max(_box.GetLeftTop().y, _box.GetRightBottom().y);
        int minY = std::min(_box.GetLeftTop().y, _box.GetRightBottom().y);

        return pos.x < maxX && pos.x > minX && pos.y < maxY && pos.y > minY;
    }

protected:
    virtual void doDraw(context_t &context) const = 0;

    virtual void doDrawIcon(int offset, context_t &context) const = 0;

    wxRect _box{};
    wxPen _pen{};
    wxBrush _brush{};
    std::string _name{"[PLACEHOLDER]"};
};

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

    void doDrawIcon(int offset, context_t &context) const override {
        wxRect _icon{};
        _icon.SetLeftTop(wxPoint(25, offset + 5));
        _icon.SetRightBottom(wxPoint(5, offset + 25));
        context.DrawRectangle(_icon);
    }
};

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

    void doDrawIcon(int offset, context_t &context) const override {
        wxRect _icon{};
        _icon.SetLeftTop(wxPoint(25, offset + 5));
        _icon.SetRightBottom(wxPoint(5, offset + 25));
        context.DrawEllipse(_icon);
    }
};

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

    void doDrawIcon(int offset, context_t &context) const override {
        wxRect _icon{};
        _icon.SetLeftTop(wxPoint(25, offset + 5));
        _icon.SetRightBottom(wxPoint(5, offset + 25));
        context.DrawLine(_icon.GetLeftTop(), _icon.GetRightBottom());
    }
};

#endif //PROJECT_SHAPE_H
