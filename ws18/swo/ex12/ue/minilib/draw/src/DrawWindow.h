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
        return *wxTRANSPARENT_BRUSH;
    }

    void on_init() override {
        mitem_cont_t tItems = {};

        tItems.push_back(std::tuple<std::string, std::string>{"&Cut", "Cut"});
        tItems.push_back(std::tuple<std::string, std::string>{"&Copy", "Copy"});
        tItems.push_back(std::tuple<std::string, std::string>{"&Paste", "Paste"});
        add_menu("&Edit", tItems);

        tItems.clear();
        for (const auto &item : _AVAIL_SHAPES) {
            tItems.push_back(
                    std::tuple<std::string, std::string>{"&" + item->getName(), "Click to draw " + item->getName()});
        }
        add_menu("&Shape", tItems);

        //add_menu("&Width", tItems);

        _menuBar = std::make_unique<MenuBar>(_AVAIL_SHAPES);
    }

    void on_mouse_left_down(ml5::mouse_event const &event) override {
        wxPoint pos = event.get_position();

        if (pos.x < _menuBar->getMenuBarWidth()) { // the menu bar was clicked
            std::unique_ptr<Shape> tShape = _menuBar->getClickedShape(pos);
            setAndMorphShape(std::move(tShape));
            return;
        }

        if (_currentShape) {
            _pShapes = _currentShape->clone();
            _pShapes->setTopLeft(pos);
        } else {
            _selectedShape = nullptr;
            // check if user clicked on existing object
            for (auto &item : _Shapes) {
                if (item->clickedOn(pos)) {
                    _selectedShape = &item;
                }
            }
            refresh();
        }
    }

    void setAndMorphShape(std::unique_ptr<Shape> tShape) {
        if (tShape) {
            setCurrentShape(std::move(tShape));
            if (_selectedShape && (*_selectedShape)->getName() != _currentShape->getName()) { // morph shape
                std::unique_ptr<Shape> newShape = _currentShape->clone();
                newShape->copyValues(**_selectedShape);
                (*_selectedShape) = std::move(newShape);
            }
        } else {
            resetShapeToCursor();
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
            if (_selectedShape && item == (*_selectedShape)) {
                item->drawBoundingBox(event.get_context());
            }
        }
        if (_pShapes)
            _pShapes->draw(event.get_context());
        _menuBar->draw(event.get_context());
    }

    void on_menu(ml5::menu_event const &event) override {
        if (event.get_item() == "Cut") {
            if (_selectedShape) {
                _clipboardShape = *_selectedShape;
                _Shapes.remove(_clipboardShape);
            }
        } else if (event.get_item() == "Copy") {
            if (_selectedShape) {
                _clipboardShape = (*_selectedShape)->clone();
            }
        } else if (event.get_item() == "Paste") {
            if (_clipboardShape) {
                _Shapes.add(_clipboardShape);
                _clipboardShape = _clipboardShape->clone(); // as we added the shape to the canvas.
            }
        } else {
            for (const auto &item : _AVAIL_SHAPES) {
                if (event.get_item() == item->getName()) {
                    setAndMorphShape(item->clone());
                }
            }
        }
        refresh();
    }


private:

    void setCurrentShape(std::unique_ptr<Shape> shape) {
        _currentShape = std::move(shape);
        _menuBar->setCurrentShape(_currentShape->getName());
        refresh();
    }

    void resetShapeToCursor() {
        _currentShape = nullptr;
        _menuBar->setCurrentShape(_menuBar->SELECTOR_NAME);
        refresh();
    }

    std::unique_ptr<Shape> _pShapes{nullptr}; // current shape being drawn
    std::unique_ptr<Shape> _currentShape{nullptr}; // shape to draw
    std::shared_ptr<Shape> _clipboardShape{nullptr}; // current shape in the clipboard
    std::shared_ptr<Shape> *_selectedShape{nullptr}; // already existing shape selected
    ml5::vector<std::shared_ptr<Shape>> _Shapes{}; // all shapes on the canvas
    std::unique_ptr<MenuBar> _menuBar{nullptr};
    const std::vector<Shape *> _AVAIL_SHAPES{ // all possible shapes, will be cloned upon selection
            new Line(wxRect{wxPoint(0, 0), wxPoint(0, 0)}, getDefaultPen(), getDefaultBrush()),
            new Ellipse(wxRect{wxPoint(0, 0), wxPoint(0, 0)}, getDefaultPen(), getDefaultBrush()),
            new Rectangle(wxRect{wxPoint(0, 0), wxPoint(0, 0)}, getDefaultPen(), getDefaultBrush())
    };
};


#endif //PROJECT_DRAWWINDOW_H
