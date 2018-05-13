program TestModVectorADT;
uses V_ADT;

var i : integer;
    tVal : integer;
    s0 : stackPtr;
begin
    init(s0);
    for i := 1 to 50 do begin
        add(s0, i);
    end;
    
    writeln('IsEmpty?', IsEmpty(s0));
    writeln('Size', size(s0));
    writeln('Capacity', capacity(s0));
    getElementAt(s0, 2, tVal);
    writeln('Second element', tVal);
    setElementAt(s0, 2, tVal + 5);
    getElementAt(s0, 2, tVal);
    writeln('Second element', tVal);
    RemoveElementAt(s0, 2);
    getElementAt(s0, 2, tVal);
    writeln('Second element', tVal);
    writeln('Size', size(s0));
    writeln('Capacity', capacity(s0));
    RemoveElementAt(s0, size(s0));
end.
