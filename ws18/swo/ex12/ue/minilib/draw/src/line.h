//
// Created by root on 1/21/19.
//

#ifndef PROJECT_LINE_H
#define PROJECT_LINE_H


#include <ml5/base/object.h>
#include <wx/gdicmn.h>
#include <wx/gtk/pen.h>
#include <ml5/gui/events.h>

class Line : public ml5::object, MI5_DERIVE(Line, ml5::object) {
MI5_INJECT(Line)
public:
    using context_t = ml5::paint_event::context_t;

    explicit Line(wxPoint start, wxPoint end, const wxPen &pen)
            : _pen{pen}, _start{start}, _end{end} {}

    void setEnd(wxPoint end) {
        _end = end;
    }

    bool empty() const {
        return _start.x == _end.x && _start.y == _end.y;
    }

    void draw(context_t &context) const {
        context.SetPen(_pen);
        context.DrawLine(_start, _end);
    }

private:
    wxPen _pen{};
    wxPoint _start{};
    wxPoint _end{};

};


#endif //PROJECT_LINE_H
