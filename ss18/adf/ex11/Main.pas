program Main;
uses ModLex, ModSyn, Crt, Windows, WinGraph;

var
    inputFileName : string;
    
begin
    writeLn('Lets go!');
    inputFileName := '';
    if ParamCount > 0 then
        inputFileName := ParamStr(1);
    initLex(inputFileName);  
newSy;
    redrawproc := S; // read a sentence using procedure for sentence symbol S
    WGMain;
    writeLn('Success: ', success);
end.
