program TestCalc;
uses ModCalcLex, ModCalcSyn;

var
    inputFileName : string;
    
begin
    inputFileName := '';
    if ParamCount > 0 then
        inputFileName := ParamStr(1);
    initCalcLex(inputFileName);
    (* test lexer
    NewSy;
    while curSy <> eofSy do begin
        writeLn(curSy);
        NewSy;
    end;
     *)
    newSy;
    S; // read a sentence using procedure for sentence symbol S
    writeLn('Success: ', success);
end.
