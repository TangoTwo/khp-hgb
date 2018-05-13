unit ParseGen_Lex;

interface
type
    symbol = (noSy,
              termSy, nonTermSy,
              isSy, identSy,
              equalSy,
              leftCurlSy, rightCurlSy,
              plusSy, mulSy, divSy, minusSy,
              leftParSy, rightParSy,
              dotSy,
              arrowLeftSy, arrowRightSy,
              leftOptSy, rightOptSy,
              leftIterSy, rightIterSy,
              barSy, orSy,
              ltSy, gtSy,
              numberSy,
              eofSy
             );
var
    sy : symbol;
    stringVal : string;
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
var
    isNonTerminal : boolean;
begin
    while (ch = ' ') or (ch = TAB_CH) do newCh;
    case ch of
        
        '=': begin sy := isSy; newCh; end;
        '.': begin sy := dotSy; newCh; end;
        '{': begin sy := leftCurlSy; newCh; end;
        '}': begin sy := rightCurlSy; newCh; end;
        '<': begin sy := arrowLeftSy; newCh; end;
        '>': begin sy := arrowRightSy;newCh; end;
        '|': begin sy := orSy; newCh; end; 
        EOF_CH: begin sy := eofSy; end;         (* don't get a newCh because eof *)
        'a'..'z','A'..'Z':
            begin
                identStr := ch;
                isNonTerminal := TRUE;
                if(ord(ch) > ord('a')) and (ord(ch) < ord('z')) then (* is lowercase *)
                    isNonTerminal := FALSE;
                newCh;
                while ch in ['a'..'z','A'..'Z','0'..'9'] do begin
                    identStr := identStr + ch;
                    newCh;
                end;
                identStr := upCase(identStr);
                if identStr = 'IDENT' then
                    sy := identSy
                else if identStr = 'EQUAL' then
                    sy := equalSy
                else if identStr = 'LT' then
                    sy := ltSy
                else if identStr = 'GT' then
                    sy := gtSy
                else if identStr = 'LEFTPAR' then
                    sy := leftParSy
                else if identStr = 'RIGHTPAR' then
                    sy := rightParSy
                else if identStr = 'BAR' then
                    sy := barSy
                else if identStr = 'LEFTOPT' then
                    sy := leftOptSy
                else if identStr = 'RIGHTOPT' then
                    sy := rightOptSy
                else if identStr = 'LEFTITER' then
                    sy := leftIterSy
                else if identStr = 'RIGHTITER' then
                    sy := rightIterSy
                else if identStr = 'PLUS' then
                    sy := plusSy
                else if identStr = 'MINUS' then
                    sy := minusSy
                else if identStr = 'TIMES' then
                    sy := mulSy
                else if identStr = 'DIV' then
                    sy := divSy
                else if identStr = 'NUMBER' then
                    sy := numberSy
                else begin
                    if(isNonTerminal) then
                        sy := nonTermSy
                    else
                        sy := termSy;
                    stringVal := lowerCase(identStr);
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
            close(inFile);
        end;
    end else begin
        ch := line[linePos];
    end; (* else *)
end;

begin
end.
