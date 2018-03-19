UNIT ModLCGReal;

INTERFACE
FUNCTION randInt() : integer;
FUNCTION randReal() : real;
PROCEDURE initLCG(randSeed : integer);

IMPLEMENTATION
USES math;
CONST
    a = 48721;
    c = 1;
    m = 32768; (*2 ^ 16*)
VAR
    x: integer;

FUNCTION randInt : INTEGER;
BEGIN
    x := (a*x+c)MOD m;
    RandInt := x;
END;

FUNCTION randReal : real;
BEGIN
    randReal := randInt/m;
END;

PROCEDURE initLCG(randSeed : integer);
BEGIN
    x:= randSeed;
END;

BEGIN
END.
