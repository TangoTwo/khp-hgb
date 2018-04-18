Program main;

uses Recursion;

procedure title(name : string);
begin
    writeLn;
    writeLn(name);
    writeLn('-------------');
end;

procedure printMatch(s, p : string);
begin
    writeLn(s, ' ', p, '=', Matching(s,p));
end;
var
    firstCharS, firstCharP : char;
    remainingCharsS, remainingCharsP : string; 
    s, p : string;
begin
    printMatch('ABC$','ABC$');
    printMatch('IMG_32323.png$','*.png$');
    printMatch('MANN$','M?NN$');
    printMatch('MXXA$','M?AA$');
end.
