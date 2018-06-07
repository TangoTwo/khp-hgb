program TestModStack;
uses ModStack_ADT2;

var i : integer;
    s0, s1 : stackPtr;
begin
    init(s0);
    init(s1);
    for i := 1 to 50 do begin
        if(Odd(i)) then
            push(s0, i)
        else
            push(s1, i);
    end;
    
    writeln('IsEmpty?', IsEmpty(s0));
    writeln('IsEmpty?', IsEmpty(s1));
    writeln('Elements:');
    while not IsEmpty(s0) do begin
        pop(s0, i);
        writeln(i);
    end;
    disposeStack(s0);
    disposeStack(s1);
end.
