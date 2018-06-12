unit ModPatternMatching;

interface
function BruteForcePos(s, p : string) : integer;
function BruteForcePos2(s, p : string) : integer;
function KnuthMorrisPratt(s, p : string) : integer;
procedure WriteAndResetStats;

implementation
var numComp : LONGINT;

function Eq(a,b : char) : boolean;
begin
    inc(numComp);
    Eq := a = b;
end;

procedure WriteAndResetStats;
begin
    writeLn('Number of comparisons: ', numComp);
    numComp := 0;
end;

function BruteForcePos(s, p : string) : integer;
var
    i, j : integer;
    pLen, sLen : integer;
    pos : integer;
begin
    pLen := Length(p);
    sLen := Length(s);
    i := 1;
    pos := 0;
    while (i <= sLen - pLen + 1) and (pos = 0) do begin
        j := 1;
        while (j <= pLen) and Eq(s[i],p[j]) do begin
            inc(j);
            inc(i);
        end;
        if j > pLen then
            pos := i - j + 1
        else
            i := i - j + 1 + 1;
    end;
    BruteForcePos := pos;
end;

function BruteForcePos2(s, p : string) : integer;
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
    BruteForcePos2 := pos;
end;

function KnuthMorrisPratt(s, p : string) : integer;
var 
    next : array[1..255] of integer; (*allow access in initNext*)
    
procedure initNext;
var i, j : integer;
begin
    next[1] := 0;
    i := 1;
    j := 2;
    repeat 
        if Eq(p[i], p[j]) then begin
            next[j] := i;
            inc(i);
            inc(j);
        end else begin
            next[j] := i;
            i := 1;
            inc(j);
        end;
    until j > length(p);
end;
var
    i, j : integer;
    pLen, sLen : integer;
    pos : integer;

begin
    pLen := Length(p);
    sLen := Length(s);
    initNext;
    i := 1;
    j := 1;
    pos := 0;
    
    repeat 
        if Eq(p[j], s[i]) then begin
            Inc(i);
            Inc(j);
        end else begin
            j := next[j];
            if j = 0 then begin
                j := 1;
                inc(i);
            end;
        end;
        if j > pLen then pos := i - j + 1;
    until (pos > 0) or (i > sLen);
    KnuthMorrisPratt := pos;
end;


begin
    numComp := 0;
end.
