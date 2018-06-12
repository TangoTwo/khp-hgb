unit ModPatternMatchingUnsharp;

interface
function Matching(s, p : string) : boolean;

procedure WriteAndResetStats;

implementation
var numComp : longint;

function Eq(s,p : char) : boolean;
begin
    inc(numComp);
    Eq := (s = p) or (p = '?') or (p = '*');
    writeLn((s = p) or (p = '?') or (p = '*'));
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
begin
    firstCharS := s[1];
    firstCharP := p[1];
    remainingCharsS := copy(s,2,length(s)-1);
    remainingCharsP := copy(p,2,length(p)-1);
    writeLn(remainingCharsP);
    if remainingCharsS = '$' then begin
        if(Eq(firstCharS,firstCharP)) then
            Matching := TRUE
        else
            Matching := FALSE;
    end else begin
        if firstCharP = '*' then begin
            if remainingCharsP[2] = '$' then begin
                Matching := TRUE;
            end
            else if firstCharS = remainingCharsP[1] then
                Matching(remainingCharsS,remainingCharsP)
            else
                Matching(remainingCharsS,p);
        end
        else begin
            Matching(remainingCharsS,remainingCharsP);
        end;
    end;
end;
begin
    numComp := 0;
end.
