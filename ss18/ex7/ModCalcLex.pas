unit ModCalcLex;

interface
type
    symbol = (numberSy, 
              plusSy, minusSy, 
              mulSy, divSy, 
              leftParSy, rightParSy, 
              eofSy, noSy);
var
    curSy : symbol;
    numVal : integer; (* number value for semantic analysis *)

procedure newSy;
procedure initCalcLex(inFileName : string);

implementation
const EOF_CH = chr(26);
    TAB_CH = chr(9);
var
    inFile : text;
    line : string;
    curChPos : integer;
    curCh : char;

procedure newCh; forward;
    
procedure initCalcLex(inFileName : string);
begin
    assign(inFile, inFileName);
    reset(inFile);
    readLn(inFile, line);
    curChPos := 0;
    NewCh;
end;

procedure newSy;
begin
    (* skip whitespace *)
    while (curCh = ' ') or (curCh = TAB_CH) do newCh;
    case curCh of
        '+':    begin curSy := plusSy;     newCh; end;
        '-':    begin curSy := minusSy;    newCh; end;
        '*':    begin curSy := mulSy;      newCh; end;
        '/':    begin curSy := divSy;      newCh; end;
        '(':    begin curSy := leftParSy;  newCh; end;
        ')':    begin curSy := rightParSy; newCh; end;
        EOF_CH: begin curSy := eofSy;      newCh; end;
        '0'..'9': begin
                (* read a number *)
                numVal := Ord(curCh) - Ord('0'); (* value of digit*)
                newCh;
                while (curCh > '0') and (curCh <= '9') do begin
                    numVal := numVal * 10 + Ord(curCh) - Ord('0');
                    newCh;
                end;
                curSy := numberSy;
            end;
        else begin curSy := noSy; newCh; end; (* default case *)
    end; (* case *)
end;

procedure newCh;
begin
    if curChPos < length(line) then begin
        inc(curChPos);
        curCh := line[curChPos]
    end else
        curCh := EOF_CH;
end;

begin
end.
