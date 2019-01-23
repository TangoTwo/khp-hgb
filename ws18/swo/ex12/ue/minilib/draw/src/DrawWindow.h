//
// Created by root on 1/21/19.
//

#ifndef PROJECT_DRAWWINDOW_H
#define PROJECT_DRAWWINDOW_H


#include <vector>
#include <ml5/ml5.h>
#include "shape.h"
#include "menuBar.h"


class DrawWindow : public ml5::window, MI5_DERIVE(DrawWindow, ml5::window) {
MI5_INJECT(DrawWindow)
private:
    static wxPen getDefaultPen() {
        return *wxBLACK_PEN;
    }

    static wxBrush getDefaultBrush() {
        return *wxGREEN_BRUSH;
    }

    void on_init() override {
        mitem_cont_t tItems = {};
        for (const auto &item : _AVAIL_SHAPES) {
            tItems.push_back(
                    std::tuple<std::string, std::string>{"&" + item->getName(), "Click to draw " + item->getName()});
        }
        add_menu("&Edit", tItems);
        add_menu("&Shape", tItems);
        add_menu("&Width", tItems);

        _menuBar = std::make_unique<MenuBar>(_AVAIL_SHAPES);
    }

    void on_mouse_left_down(ml5::mouse_event const &event) override {
        wxPoint pos = event.get_position();

        if (pos.x < _menuBar->getMenuBarWidth()) { // the menu bar was clicked
            std::unique_ptr tShape = _menuBar->getClickedShape(pos);
            if (tShape)
                setCurrentShape(std::move(tShape));
            return;
        }

        if (_currentShape) {
            _pShapes = _currentShape->clone();
            _pShapes->setTopLeft(pos);
        }
    }

    void on_mouse_move(const ml5::mouse_event &event) override {
        wxPoint pos = event.get_position();

        if (_pShapes) {
            _pShapes->setBottomRight(pos);
            refresh();
        }
    }

    void on_mouse_left_up(const ml5::mouse_event &event) override {
        wxPoint pos = event.get_position();

        if (_pShapes && !_pShapes->empty()) {
            _pShapes->setBottomRight(pos);
            _Shapes.add(std::move(_pShapes));
            refresh();
        }
    }

    void on_paint(const ml5::paint_event &event) override {
        for (const auto &item : _Shapes) {
            item->draw(event.get_context());
        }
        if (_pShapes)
            _pShapes->draw(event.get_context());
        _menuBar->draw(event.get_context());
    }

    void on_menu(ml5::menu_event const &event) override {
        for (const auto &item : _AVAIL_SHAPES) {
            if (event.get_item() == item->getName()) {
                setCurrentShape(item->clone());
            }
        }
    }


private:

    void setCurrentShape(std::unique_ptr<Shape> shape) {
        _currentShape = std::move(shape);
        _menuBar->setCurrentShape(_currentShape->getName());
        refresh();
    }

    std::unique_ptr<Shape> _pShapes{nullptr};
    std::unique_ptr<Shape> _currentShape{nullptr};
    ml5::vector<std::unique_ptr<Shape>> _Shapes{};
    std::unique_ptr<MenuBar> _menuBar{nullptr};
    const std::vector<Shape *> _AVAIL_SHAPES{
            new Line(wxRect{wxPoint(0, 0), wxPoint(0, 0)}, getDefaultPen(), getDefaultBrush()),
            new Ellipse(wxRect{wxPoint(0, 0), wxPoint(0, 0)}, getDefaultPen(), getDefaultBrush()),
            new Rectangle(wxRect{wxPoint(0, 0), wxPoint(0, 0)}, getDefaultPen(), getDefaultBrush())
    };
};


#endif //PROJECT_DRAWWINDOW_H
