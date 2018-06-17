program TestCalc;
uses ModLex, ModSyn;

var
    inputFileName : string;
    
begin
    inputFileName := '';
    if ParamCount > 0 then
        inputFileName := ParamStr(1);
    initLex(inputFileName);
    newSy;
    S; // read a sentence using procedure for sentence symbol S
    writeLn('Success: ', success);
end.
