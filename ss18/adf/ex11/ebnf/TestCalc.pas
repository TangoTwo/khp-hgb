program TestCalc;
uses ModCalcLex, ModCalcSyn;

var
    inputFileName : string;
    
begin
    inputFileName := '';
    if ParamCount > 0 then
        inputFileName := ParamStr(1);
    initCalcLex(inputFileName);
    newSy;
    S; // read a sentence using procedure for sentence symbol S
    writeLn('Success: ', success);
end.
