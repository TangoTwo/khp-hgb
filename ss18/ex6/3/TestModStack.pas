program TestModStack;
uses S_ADT;

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
    
    writeln('IsEmpty(s0) = ', IsEmpty(s0));
    writeln('IsEmpty(s1) = ', IsEmpty(s1));
    writeln('Popping s0 (all odd numbers) reversed (49 - 1)');
    writeln('Elements:');
    while not IsEmpty(s0) do begin
        pop(s0, i);
        writeln(i);
    end;
    disposeStack(s0);
    disposeStack(s1);
end.
