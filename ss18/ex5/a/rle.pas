program rle;

uses sysutils;

function fileExists(fromFileName : string) : boolean;
var
    f : TEXT;
begin
    (*$I-*) 
    assign(f, fromFileName);
    Reset(f); //Creates error
    if IOResult <> 0 then begin 
        fileExists := FALSE;
    end else
        fileExists := TRUE;
    (*$I+*)
end;

function isNumber(character : char) : boolean;
begin
    if(ord(character) < 48) or (ord(character) > 57)then
        isNumber := FALSE
    else
        isNumber := TRUE;
end;

function addCharCountAtEnd(previousChar : char; charOccurances : integer; compressedLine : string) : string;
var
    charOccurancesString : string;
begin
    if(charOccurances > 2) then begin
        str(charOccurances, charOccurancesString);
        compressedLine := compressedLine + previousChar + charOccurancesString;
    end else
        compressedLine := compressedLine + stringOfChar(previousChar, charOccurances);
    addCharCountAtEnd := compressedLine;
end;

function compressLine(line : string) : string;
var
    i, lineLength : integer;
    previousChar, currentChar : char;
    charOccurances : integer;
    compressedLine : string;
begin
    i := 1;
    lineLength := length(line);
    charOccurances := 1;
    compressedLine := '';
    while (i <= lineLength) do begin
        currentChar := line[i];
        if(isNumber(currentChar)) then begin
            writeln('Can''t compress text with numbers in it!');
            halt;
        end;
        if(currentChar = previousChar) then begin
            inc(charOccurances);
        end else if (i = 1) then
            previousChar := currentChar // there is no prev character so just set cur char to prev.
        else begin
            compressedLine := addCharCountAtEnd(previousChar, charOccurances, compressedLine);
            previousChar := currentChar;
            charOccurances := 1;
        end;
        inc(i);
    end;
    compressedLine := addCharCountAtEnd(previousChar, charOccurances, compressedLine);
    compressLine := compressedLine;
end;

procedure compress(fromFileName, toFileName : string);
var
    inFile, outFile : TEXT;
    line : string;
begin
    assign(inFile, fromFileName);
    assign(outFile, toFileName);
    reset(inFile);
    rewrite(outFile); // overwrite if file exists
    while not eof(inFile) do begin
        readln(inFile, line);
        line := compressLine(line);
        writeln(outFile, line);
    end;
    close(inFile);
    close(outFile);
end;

function decompressLine(line : string) : string;
var
    i, lineLength : integer;
    decompressedLine : string;
begin
    decompressedLine := '';
    i := 1;
    lineLength := length(line);
    while (i <= lineLength) do begin
        if(isNumber(line[i])) then begin
            decompressedLine := decompressedLine + stringOfChar(line[i-1], strToInt(line[i])-1);
        end else
            decompressedLine := decompressedLine + line[i];
        inc(i);
    end;
    decompressLine := decompressedLine;
end;

procedure decompress(fromFileName, toFileName : string);
var
    inFile, outFile : TEXT;
    line : string;
begin
    assign(inFile, fromFileName);
    assign(outFile, toFileName);
    reset(inFile);
    rewrite(outFile); // overwrite if file exists
    while not eof(inFile) do begin
        readln(inFile, line);
        line := decompressLine(line);
        writeln(outFile, line);
    end;
    close(inFile);
    close(outFile);
end;

var
    option : string;
    fromFileName, toFileName : string;
    
begin
    option := '';
    fromFileName := '';
    toFileName := '';
    
    case paramCount of
        0: begin
            end;
        1: begin
                if(paramStr(1)[1] = '-') then
                    option := paramStr(1)
                else
                    fromFileName := paramStr(1);
            end;
        2: begin 
                if paramStr(1)[1] = '-' then begin
                    option := paramStr(1);
                    fromFileName := paramStr(2);
                end else begin
                    fromFileName := paramStr(1);
                    toFileName := paramStr(2);
                end;
            end;
        3: begin 
                option := paramStr(1);
                fromFileName := paramStr(2);
                toFileName := paramStr(3);
            end;
        else begin
            writeLn('Usage: rle [ -c | -d ] [ inFile [ outFileName ] ]');
            halt;
        end;
    end;

    if not fileExists(fromFileName) then begin
        writeLn('inFile does not exist! Unable to complete operation');
        halt;
    end;
    
    if (option = '-c') or (option = '') then // default -b
        compress(fromFileName, toFileName)
    else if (option = '-d') then
        decompress(fromFileName, toFileName)
    else begin
        writeLn('Unknown option ', option);
        halt;
    end;
end.

