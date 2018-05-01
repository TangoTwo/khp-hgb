program TestModStack;
uses V_ADS;

var i : integer;
    tVal : integer;
begin
    init;
    for i := 1 to 50 do begin
        add(i);
    end;
    
    writeln('IsEmpty?', IsEmpty);
    writeln('Size', size);
    writeln('Capacity', capacity);
    getElementAt(2, tVal);
    writeln('Second element', tVal);
    setElementAt(2, tVal + 5);
    getElementAt(2, tVal);
    writeln('Second element', tVal);
    RemoveElementAt(2);
    getElementAt(2, tVal);
    writeln('Second element', tVal);
    writeln('Size', size);
    writeln('Capacity', capacity);
    RemoveElementAt(size);
end.
