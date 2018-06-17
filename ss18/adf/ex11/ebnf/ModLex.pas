unit ModLex;

interface
type
    symbol = (numberSy, identSy
              equalSy, semicolonSy, plusSy,
              showSy, hideSy, 
              lineSy, rectangleSy,
              circleSy, pictureSy,
              moveSy,
              eofSy, noSy);
var
    curSy : symbol;
    numVal : integer; (* number value for semantic analysis *)
    identStr : string;

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
    
procedure initLex(inFileName : string);
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
        '=':    begin curSy := equalSy;     newCh; end;
        ';':    begin curSy := semicolonSy;    newCh; end;
        '+':    begin curSy := plusSy;    newCh; end;
        EOF_CH: begin curSy := eofSy;      newCh; end;
        'a'..'z', 'A'..'Z': BEGIN
          identStr := '';
          WHILE ch IN ['a'.. 'z', 'A' ..'Z', '0'..'9', '_'] DO BEGIN
            identStr := Concat(identStr, UpCase(ch));
            NewCh;
          END; (*WHILE*)
          IF      identStr = 'SHOW' THEN
            sy := showSy
          ELSE IF identStr = 'HIDE' THEN
            sy := hideSy
          ELSE IF identStr = 'LINE' THEN
            sy := lineSy
          ELSE IF identStr = 'RECTANCLE' THEN
            sy := rectangleSy
          ELSE IF identStr = 'CIRCLE' THEN
            sy := circleSy
          ELSE IF identStr = 'PICTURE' THEN
            sy := pictureSy
          ELSE IF identStr = 'MOVE' THEN
            sy := moveSy
          ELSE
            sy := identSy;
        END;
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
