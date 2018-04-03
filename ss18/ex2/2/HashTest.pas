program HashTest;

uses (*ModHashTableChaining;*)
    ModHashTableLinearProbing;
    

var
    c, maxC : integer;
    mostFreqWord : string;
    testWords : array[1..10] of string;
    i : integer;
begin
    init;
    testWords[1] := 'abc';
    testWords[2] := 'gkr';
    testWords[3] := 'abc';
    testWords[4] := 'cba';
    testWords[5] := 'bac';

    maxC := 0;

    for i := 1 to 5 do begin
        c := addOrInc(testWords[i]);
        if c > maxC then begin
            maxC := c;
            mostFreqWord := testWords[i];
        end;
    end;
    writeTable;
    writeLn('Most frequent word ', mostFreqWord, ' ', maxC);
end.
