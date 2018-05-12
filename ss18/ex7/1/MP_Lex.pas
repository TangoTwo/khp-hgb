unit MP_Lex;

interface
type
    symbol = (noSy,
              termSy, nonTermSy
              equalSy, identSy
              leftCurlSy, rightCurlSy,
              plusSy, mulSy, divSy, minusSy,
              leftParSy, rightParSy,
              dotSy,
              arrowLeftSy, arrowRightSy,
              leftOptSy, rightOptSy,
              leftIterSy, rightIterSy,
              barSy, orSy,
              ltSy, gtSy
             );
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
        
        '=': begin sy := equalSy; newCh; end;
        '.': begin sy := dotSy; newCh; end;
        '{': begin sy := leftCurlSy; newCh; end;
        '}': begin sy := rightCurlSy; newCh; end;
        '<': begin sy := arrowLeftSy; newCh; end;
        '>': begin sy := arrowRightSy;newCh; end;
        '|': begin sy := orSy; newCh; end;
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
                else
                    sy := identSy;
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
