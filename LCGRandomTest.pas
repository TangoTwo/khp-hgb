PROGRAM LCGRandomTest;
USES ModLCGRandom;

VAR i : INTEGER;
BEGIN
    InitLCG(1403);
    FOR i := 1 TO 10 DO BEGIN
        WriteLn(RandBetweenDiv(1,2));
    END;
    END.
