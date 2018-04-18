unit Recursion;

interface
function Matching(s, p : string) : boolean;

procedure WriteAndResetStats;

implementation
var numComp : longint;

function Eq(s,p : char) : boolean;
begin
    inc(numComp);
    Eq := (s = p) or (p = '?') or (p = '*');
end;

procedure WriteAndResetStats;
begin
    writeLn('Number of comparisons: ', numComp);
    numComp := 0;
end;

function Matching(s,p : string) : boolean;
var
    firstCharS, firstCharP : char;
    remainingCharsS, remainingCharsP : string; 
    matchingSingle, matchingRemaining : boolean;
begin
    firstCharS := s[1];
    firstCharP := p[1];
    matchingRemaining := TRUE;
    matchingSingle := FALSE;
    Matching := TRUE;
    remainingCharsS := copy(s,2,length(s)-1);
    remainingCharsP := copy(p,2,length(p)-1);
    if(Eq(firstCharS,firstCharP)) then
        matchingSingle := TRUE
    else
        Matching := FALSE;
    if(remainingCharsS <> '$') and (matchingSingle <> FALSE) then
        if(firstCharP = '*') then begin
           if(firstCharS = remainingCharsP[1]) then
               matchingRemaining := Matching(s,remainingCharsP)
           else
               matchingRemaining := Matching(remainingCharsS,p);
        end
        else
            matchingRemaining := Matching(remainingCharsS,remainingCharsP);
    Matching := matchingSingle and matchingRemaining;
end;
begin
    numComp := 0;
end.
