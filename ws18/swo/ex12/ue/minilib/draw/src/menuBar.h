//
// Created by root on 1/23/19.
//

#ifndef PROJECT_MENUBAR_H
#define PROJECT_MENUBAR_H

#include <ml5/ml5.h>
#include "shape.h"

#define LEFT_BAR_WIDTH 30

class MenuBar : public ml5::object, MI5_DERIVE(MenuBar, ml5::object) {
MI5_INJECT(MenuBar)
private:
    using context_t = ml5::paint_event::context_t;

    static wxPen _getDefaultPen() {
        return *wxBLACK_PEN;
    }

    static wxBrush _getDefaultBrush() {
        return *wxWHITE_BRUSH;
    }

    class Button : public ml5::object, MI5_DERIVE(Button, ml5::object) {
    MI5_INJECT(Button)
    public:
        Button(int offset, Shape *shape) : _shape{shape} {
            _box.SetLeftTop(wxPoint(0, offset));
            _box.SetRightBottom(wxPoint(LEFT_BAR_WIDTH, offset + LEFT_BAR_WIDTH));
        };

        Button(Button &&other) noexcept : _shape{other._shape} {
            _box.SetLeftTop(wxPoint(0, other.getOffset()));
            _box.SetRightBottom(wxPoint(LEFT_BAR_WIDTH, other.getOffset() + LEFT_BAR_WIDTH));
            other._shape = nullptr;
        };

        void draw(context_t &context, std::string &_activeShape) const {
            wxBrush tBrush = context.GetBrush();
            wxPen tPen = context.GetPen();

            context.SetPen(*wxBLACK_PEN);
            context.SetBrush(*wxWHITE_BRUSH);
            if (_activeShape == _shape->getName()) {
                context.SetPen(*wxWHITE_PEN);
                context.SetBrush(*wxBLACK_BRUSH);
                context.DrawRectangle(_box);
            }
            _shape->drawIcon(getOffset(), context);
            context.SetPen(tPen);
            context.SetBrush(tBrush);
        }

        int getOffset() const {
            return _box.GetTop();
        }

        Shape *getShape() const {
            return _shape;
        }


    private:
        Shape *_shape;
        wxRect _box{wxPoint(0, 0), wxPoint(0, 0)};
    };

    std::vector<Button> _buttons;
    std::string _activeShape{};
public:
    explicit MenuBar(const std::vector<Shape *> shapes) {
        int curOffset = 0;
        for (const auto &item : shapes) {
            _buttons.emplace_back(Button(curOffset, item));
            curOffset += LEFT_BAR_WIDTH;
        }
    }

    void draw(context_t &context) const {
        context.SetPen(_getDefaultPen());
        context.SetBrush(_getDefaultBrush());
        context.DrawRectangle(wxRect(wxPoint(-1, -1), wxPoint(LEFT_BAR_WIDTH, context.GetWindow()->m_clientHeight)));
        for (const auto &button : _buttons) {
            button.draw(context, _activeShape);
        }
    }

    void setCurrentShape(const std::string &shapeName) {
        _activeShape = shapeName;
    }

    int getMenuBarWidth() {
        return LEFT_BAR_WIDTH;
    }

    std::unique_ptr<Shape> getClickedShape(const wxPoint &pos) {
        for (const auto &button : _buttons) {
            if (button.getOffset() < pos.y && button.getOffset() + LEFT_BAR_WIDTH > pos.y)
                return button.getShape()->clone();
        }
        return nullptr;
    }
};


#endif //PROJECT_MENUBAR_H
