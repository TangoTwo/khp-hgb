unit ModStringHash;

interface
function stringHash1(w : string) : integer;

implementation
function stringHash1(w : string) : integer;
var i : integer;
    sum : integer;
begin
    sum := 0;
    for i := 1 to length(w) do begin
        sum := (sum + Ord(w[i])) mod 32768;
    end;
    stringHash1 := sum;
end;

begin
end.
