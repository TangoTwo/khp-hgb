unit FileWriter;

interface

procedure initOutFile(outFileExt : string);
procedure closeOutFile;
procedure writeToFile(line : string; indent : integer); (* write and restructure*)

implementation
const
    INDENT_STR = '   ';
    
var
    outFile : text;
    currentIndent : integer;

procedure addToIndent(indent : integer);
begin
    currentIndent := currentIndent + indent;
    if(currentIndent < 0) then begin
        writeln('Cannot set indent to something smaller than 0');
        currentIndent := 0;
    end;
end;

procedure initOutFile(outFileExt : string);
begin
    currentIndent := 0;
    assign(outFile, outFileExt);
    rewrite(outFile);
end;

procedure closeOutFile;
begin
    close(outFile);
end;

procedure writeToFile(line : string; indent : integer); (* write and restructure*)
var 
    tIdentStr : string;
    i : integer;
begin
    i := 0;
    tIdentStr := '';
    if(indent < 0) then         (* BESCHREIB DEN SCHAAS *)
        addToIndent(indent);
    while(i < currentIndent) do begin
        tIdentStr := tIdentStr + INDENT_STR;
        inc(i);
    end;
    writeLn(outFile, tIdentStr, line);
    if(indent > 0) then
        addToIndent(indent);
end;

begin
end.
