unit ModPatternMatching;

interface
function BruteForcePos(s, p : string) : integer;
function BruteForcePos2(s, p : string) : integer;
function KnuthMorrisPratt(s, p : string) : integer;
function BruteForceRL(s,p : string) : integer;
function BoyerMoore(s,p : string) : integer;
function RabinKarp(s,p : string) : integer;

procedure WriteAndResetStats;

implementation
var numComp : longint;

function Eq(a,b : char) : boolean;
begin
    inc(numComp);
    Eq := (a = b) or (a = '*');
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

function BruteForceRL(s,p : string) : integer;
var
    i, j : integer;
    pLen, sLen : integer;
begin
    pLen := Length(p);
    sLen := Length(s);
    i := pLen;
    j := pLen;
    repeat
        if eq(p[j], s[i]) then begin
            dec(i);
            dec(j);
        end else begin
            i := i + (pLen - j) + 1;
            j := pLen;
        end;
    until (j <= 0) or (i > sLen);
    if j <= 0 then
        BruteForceRL := i + 1
    else
        BruteForceRL := 0; (*no match*)
end;


function max(a, b : integer) : integer;
begin
    if a > b then max := a else max := b;
end;

function BoyerMoore(s,p : string) : integer;
var
    i, j : integer;
    pLen, sLen : integer;
    next : array[char] of integer;
    
procedure initNext;
var ch : char;
    i : integer;
begin
    (* clear next *)
    for ch := Low(next) to high(next) do begin
        next[ch] := 0;
    end;
    for i := 1 to pLen do
        next[p[i]] := i;
end;

begin
    pLen := Length(p);
    sLen := Length(s);
    initNext;
    i := pLen;
    j := pLen;
    repeat
        if eq(p[j], s[i]) then begin
            dec(i);
            dec(j);
        end else begin
            (* don't shift pattern left*)
            i := max(i + (pLen - j) + 1, (*shift one pos right*)
                        i + pLen - next[s[i]] (*shift to match symbols in text and pattern *)
                    ); 
            j := pLen;
        end;
    until (j <= 0) or (i > sLen);
    if j <= 0 then
        BoyerMoore := i + 1
    else
        BoyerMoore := 0; (*no match*)
end;

function RabinKarp(s, p : string) : integer;
const d = 256;
    q = 524287; (* 2^19 -1 *) (* q * d = 134217472 < max(longint) *)
var i, j : integer;
    hs, hp : longint;
    dm : longint;
    pLen, sLen : integer;
    pos : integer;
begin
    pLen := Length(p);
    sLen := Length(s);
    (*calc hs(1) and hp *)
    hs := 0;
    hp := 0;
    dm := 1;
    for i := 1 to pLen -1 do
        dm := (dm * d) mod q;
    for i := 1 to pLen do begin
        hs := (hs * d + ord(s[i])) mod q;
        hp := (hp * d + ord(p[i])) mod q;
    end;
    (* check each position in s *)
    i := 1;
    pos := 0;
    while (i <= sLen - pLen + 1) and (pos = 0) do begin
        if hs = hp then begin
            j := 1;
            while (j <= pLen) and eq(p[j], s[i+j-1]) do begin
                inc(j);
            end;
            if j > pLen then pos := i; (*complete match found*)
        end;
        (* incremental update of hs *)
        hs := (hs + d * q - ord(s[i]) *dm) mod q;
        hs := (hs * d + ord(s[i+pLen])) mod q;
        inc(i);
    end;
    RabinKarp := pos;
end;
    

begin
    numComp := 0;
end.
