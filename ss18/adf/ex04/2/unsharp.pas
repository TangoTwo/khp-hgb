unit unsharp;

interface
function BruteForcePosUnsharp(s, p : string) : integer; 

procedure WriteAndResetStats;

implementation
var numComp : longint;

function Eq(a,b : char) : boolean;
begin
    inc(numComp);
    Eq := (a = b) or (a = '?');
end;

procedure WriteAndResetStats;
begin
    writeLn('Number of comparisons: ', numComp);
    numComp := 0;
end;

function BruteForcePosUnsharp(s, p : string) : integer;
var
    i, j : integer;
    pLen, sLen : integer;
    pos : integer;
    startI : integer;
begin
    pLen := Length(p);
    sLen := Length(s);
    i := 1;
    j := 1;
    startI := 1;
    pos := 0;
    
    repeat 
        if Eq(p[j], s[i]) then begin
            Inc(i);
            Inc(j);
        end else begin
            (*mischtmatscht*)
            i := i - j + 2;
            startI := i;
            j := 1;
        end;
        if j > pLen then pos := startI;
    until (pos > 0) or (i > sLen);
    BruteForcePosUnsharp := pos;
end;

begin
end.
