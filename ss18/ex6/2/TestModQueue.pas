program TestModQueue;
uses Q_ADS;

var i : integer;
begin
    init;
    for i := 1 to 10 do begin
        writeln('Enqueueing ', i);
        enqueue(i);
    end;
    
    writeln('IsEmpty = ', IsEmpty);
    writeln('Order should now be the same as enqueueing while dequeueing');
    writeln('Elements:');
    while not IsEmpty do begin
        writeln(dequeue);
    end;
    writeln('IsEmpty = ', IsEmpty);
    disposeQueue;
end.
