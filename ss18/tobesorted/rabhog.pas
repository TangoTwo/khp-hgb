PROGRAM rabhog;
uses ModLCGRandom;

var h, i : integer;
    len : longint;
    
begin
    h := 314;
    i:= 314;
    len := 0;
    repeat
        initLCG(h);
        RandInt;
        h := RandInt;
        initLCG(i);
        i := RandInt;
        inc(len);
    until h = i;
    WriteLn(len);
    len := 0;
    repeat
        initLCG(i);
        i := RandInt;
        Inc(len);
    until h = i;
    WriteLn(len);
end.

