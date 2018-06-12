unit ModPatternMatchingUnsharp;

interface
procedure BruteForcePos(s, p : string;
                       var lsTemp, rsTemp, lpTemp, rpTemp : integer
                      );

procedure WriteAndResetStats;

implementation
var numComp : longint;

function Eq(a,b : char) : boolean;
begin
    inc(numComp);
    Eq := (a = b) or (a = '?') or (b = '?');
end;

procedure WriteAndResetStats;
begin
    writeLn('Number of comparisons: ', numComp);
    numComp := 0;
end;

procedure BruteForcePos(s, p : string;
                       var lsTemp, rsTemp, lpTemp, rpTemp : integer
                      );
var
    i : integer;
    pLen, sLen : integer;
    curLength, longestLength : integer;
begin
    pLen := Length(p);
    sLen := Length(s);
    i := 0;
    curLength := 0;
    longestLength := 0;
    for i := 1 to sLen do begin
        if slen - i < longestLength then// remaining text to match is already shorter than longest length
            break;
        if Eq(s[i],p[1]) then begin
            curLength := 1;
            while Eq(s[i+curLength],p[curLength+1]) and (curLength <= pLen) do begin
                inc(curLength);
            end;
            if curLength > longestLength then begin
                lsTemp := i;
                rsTemp := i + curLength - 1;
                lpTemp := 1;
                rpTemp := curLength;
                longestLength := rsTemp - lsTemp + 1;
            end;
            curLength := 0;
        end;
    end;
end;

begin
end.
