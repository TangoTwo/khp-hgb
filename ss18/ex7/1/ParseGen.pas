program ParseGen;
uses ParseGen_Lex, ParseGen_Syn, FileWriter;

var inFileName, outFileName : string;
    tempString : string;

begin
    if paramCount <> 2 then begin
        writeLN('Usage: ParseGen <grammar.syn> <grammar.pas>');
        halt;
    end;
    inFileName := paramStr(1);
    outFileName := paramStr(2);
    initLex(paramStr(1));
    initOutFile(outFileName);
    tempString := '(* parsing functions generated from file ''' + paramStr(1) + ''' *)';
    writeToFile(tempString, 0);
    writeToFile('', 0);
    parseArg;
    tempString := '(* generation ended successfully *)';
    writeToFile(tempString, 0);
    closeOutFile;
end.
