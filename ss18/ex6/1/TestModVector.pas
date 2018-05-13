program TestModVector;
uses V_ADS;

var i : integer;
    tVal : integer;
begin
    init;
    for i := 1 to 50 do begin
        add(i);
    end;
    
    writeln('IsEmpty = ', IsEmpty);
    writeln('Size = ', size);
    writeln('Capacity = ', capacity);
    getElementAt(2, tVal);
    writeln('Second element = ', tVal);
    writeln('Add 5 to second element');
    setElementAt(2, tVal + 5);
    getElementAt(2, tVal);
    writeln('Second element (should now be 7) = ', tVal);
    writeln('Now remove second element --> third element shifts into its place.');
    writeln('Thus second element should now be ''3'' and size should be one less.');
    RemoveElementAt(2);
    getElementAt(2, tVal);
    writeln('Second element = ', tVal);
    writeln('Size = ', size);
    writeln('Capacity = ', capacity);
    RemoveElementAt(size);
end.
