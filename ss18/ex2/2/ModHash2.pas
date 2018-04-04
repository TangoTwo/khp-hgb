unit ModHash2;

interface
function stringHash2(w : string) : integer;

implementation
function stringHash2(w:string) : integer;
 var i : integer;
    sum : integer;
begin
    sum := 1;
    for i := 1 to length(w) do begin
        sum := (sum * Ord(w[i])+Ord(w[i])) mod 32768;
    end;
    stringHash2 := sum;
end;

begin
end.
