program TestModStack;
uses Q_ADS;

var i : integer;
begin
    init;
    for i := 1 to 50 do begin
        enqueue(i);
    end;
    
    writeln('IsEmpty?', IsEmpty);
    writeln('Elements:');
    while not IsEmpty do begin
        writeln(dequeue);
    end;
    disposeStack;
end.
