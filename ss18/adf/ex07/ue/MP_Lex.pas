unit MP_Lex;

interface
type
    symbol = (noSy,
              numSy, idSy,
              plusSy, minusSy, mulSy, divSy,
              leftParSy, rightParSy,
              assignSy, 
              commaSy, semicolonSy, dotSy,
              colonSy,
              programSy, varSy, beginSy, endSy,
              readSy, writeSy, integerSy, 
              eofSy);
var
    sy : symbol;
    numberVal : integer;
    identStr: string;

procedure initLex(inFileName : string);
procedure newSy;

implementation
const EOF_CH = chr(26);
    TAB_CH = chr(9);
    
var inFile : text;
    line : string;
    linePos : integer;
    ch : char;

procedure newCh; FORWARD;

procedure initLex(inFileName : string);
begin
    assign(inFile, inFileName);
    reset(inFile);
    line := '';
    linePos := 0;
    newCh;
end;

procedure newSy;
begin
    while (ch = ' ') or (ch = TAB_CH) do newCh;
    case ch of
        
        '+': begin sy := plusSy; newCh; end;
        '-': begin sy := minusSy; newCh; end;
        '*': begin sy := mulSy; newCh; end;
        '/': begin sy := divSy; newCh; end;
        ':': begin 
                newCH;
                if ch = '=' then begin
                    sy := assignSy;
                    NewCh;
                end else
                    sy := colonSy;
            end;
        ';': begin sy := semicolonSy; newCh; end;
        '.': begin sy := dotSy; newCh; end;
        ',': begin sy := commaSy; newCh; end;
        '(': begin sy := leftParSy; newCh; end;
        ')': begin sy := rightParSy; newCh; end;
        EOF_CH: begin sy := eofSy; newCh; end;
        '_','a'..'z','A'..'Z':
            begin
                identStr := ch;
                newCh;
                while ch in ['_','a'..'z','A'..'Z','0'..'9'] do begin
                    identStr := identStr + ch;
                    newCh;
                end;
                identStr := upCase(identStr);
                if identStr = 'PROGRAM' then
                    sy := programSy
                else if identStr = 'BEGIN' then
                    sy := beginSy
                else if identStr = 'END' then
                    sy := endSy
                else if identStr = 'VAR' then
                    sy := varSy
                else if identStr = 'INTEGER' then
                    sy := integerSy
                else if identStr = 'READ' then
                    sy := readSy
                else if identStr = 'WRITE' then
                    sy := writeSy
                else
                    sy := idSy;
            end;
        '0'..'9':
        begin
            numberVal := ord(ch) - ord('0');
            newCh;
            while ch in ['0'..'9'] do begin
                numberVal := numberVal * 10 + ord(ch) - ord('0');
                newCh;
            end;
        end;
        else begin
            sy := noSy;
        end;
    end;
end;

procedure newCh;
begin
    inc(linePos);
    if linePos > length(line) then begin
        if not eof(inFile) then begin
            readLn(inFile, line);
            linePos := 0;
            ch := ' ';
        end else begin
            ch := EOF_CH;
            line := '';
            linePos := 0;
        end;
    end else begin
        ch := line[linePos];
    end; (* else *)
end;

begin
end.
