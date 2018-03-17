program pi;

var 
    countInCircle : integer;
    n : integer;
    i : integer;
    x, y : real;

BEGIN
    countInCircle := 0;
    n := 10000;
    (* Using Monte Carlo Method*)
    FOR i := 1 to n do begin
        x := random;
        y := random;
        if(sqrt(x*x + y*y) <= 1) then
            inc(countInCircle);
    end;
    writeln('Pi is approx.:', 4 * countInCircle/n);
END.
