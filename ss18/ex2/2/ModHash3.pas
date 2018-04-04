unit ModHash3;

interface
function stringHash3(w : string) : integer;

implementation
function stringHash3(w : string) : integer;
var i : integer;
    sum : integer;
begin
    sum := 1;
    for i := 1 to length(w) do begin
        sum := (sum * Ord(w[i])) mod 32768;
    end;
    stringHash3 := sum;
end;

begin
end.
