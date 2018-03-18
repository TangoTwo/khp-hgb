 
UNIT ModLCGRandom;

INTERFACE
FUNCTION RandInt() : INTEGER;
FUNCTION RandBetween(l, u : INTEGER) : INTEGER;
FUNCTION RandBetweenDiv(l, u : INTEGER) : INTEGER;
PROCEDURE InitLCG(randSeed : INTEGER);

IMPLEMENTATION
CONST
    a = 48721;
    c = 1;
    m = 32768; (*2 ^ 16*)
VAR
    x: LONGINT;

FUNCTION RandInt : INTEGER;
BEGIN
    x := (a*x+c)MOD m;
    RandInt := x;
END;

PROCEDURE InitLCG(randSeed : INTEGER);
BEGIN
    x:= randSeed;
END;

FUNCTION RandBetweenDiv(l, u : INTEGER) : INTEGER;
VAR 
    r, range : INTEGER;
BEGIN
    r := RandInt();
    range := u - l;
    RandBetweenDiv := l + Trunc((r/m)*range);
END;

FUNCTION RandBetween(l, u : INTEGER) : INTEGER;
VAR
    r, range, max : INTEGER;
BEGIN
    IF l >= u THEN BEGIN
        WriteLn('l >= u in RandBetween');
        HALT;
    range := u-l;
    max := m DIV range * range;
    r := RandInt;
    WHILE (r >= max) DO
        r := RandInt;
    END;
    RandBetween := l + r MOD range;
END;


BEGIN
END.
