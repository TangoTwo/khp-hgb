Program main;

uses ModPatternMatchingUnsharp;

procedure findLongestMatch(s1, s2: string;
                           var ss: string;
                           var l1, r1, l2, r2: integer);
var
    pos : integer;
    l1Temp,r1Temp,l2Temp,r2Temp : integer;
    s2Length : integer;
    s2Temp : string;
    lettersRemovedFromS2 : integer;
//s2temp : string;
longestLength : integer;
begin
    s2Length := length(s2);
    s2Temp := s2;
    l1Temp := 0;
    r1Temp := 0;
    l2Temp := 0;
    r2Temp := 0;
    lettersRemovedFromS2 := 0;
    //s2temp := s2; // we will shorten s2temp one letter at a time
    longestLength := 0;
    for pos := 1 to s2Length do begin
        BruteForcePos(s1, s2Temp, l1Temp, r1Temp, l2Temp, r2Temp); // search for s2 in s1
        if(r1Temp-l1Temp > longestLength) then begin
            longestLength := r1Temp-l1Temp+1;
            l1 := l1Temp;
            r1 := r1Temp;
            l2 := l2Temp + lettersRemovedFromS2;
            r2 := r2Temp + lettersRemovedFromS2;
        end;
        delete(s2Temp,1,1); // remove first letter from s2
        inc(lettersRemovedFromS2);
    end;
    ss := copy(s1,l1,longestLength);
end;

procedure title(name : string);
begin
    writeLn;
    writeLn(name);
    writeLn('-------------');
end;

var
    s1, s2 : string;
    ss : string;
    l1,r1,l2,r2 : integer;
begin
    s1 := 'bba';
    s2 := 'abbaabba';
    ss := '';
    l1 := 0;
    r1 := 0;
    l2 := 0;
    r2 := 0;
    title('findLongestMatch');
    findLongestMatch(s1, s2, ss, l1, r1, l2, r2);
    writeLn(ss);
    writeln(l1);
    writeln(r1);
    writeln(l2);
    writeln(r2);
end.
