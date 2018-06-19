unit ModLex;

interface
type
    symbol = (numberSy, identSy,
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
procedure initLex(inFileName : string);

implementation
const EOF_CH = chr(26);
    TAB_CH = chr(9);
    WNL_CH = chr(13);
    LNL_CH = chr(10);
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
    writeln(ord(curCh));
    while (curCh = ' ') or (curCh = TAB_CH) or (curCh = WNL_CH) or (curCh = LNL_CH) do newCh;
    case curCh of
        '=':    begin curSy := equalSy;     newCh; end;
        ';':    begin curSy := semicolonSy;    newCh; end;
        '+':    begin curSy := plusSy;    newCh; end;
        EOF_CH: begin curSy := eofSy;      newCh; end;
        'a'..'z', 'A'..'Z': BEGIN
          identStr := '';
          WHILE curCh IN ['a'.. 'z', 'A' ..'Z', '0'..'9', '_'] DO BEGIN
            identStr := Concat(identStr, UpCase(curCh));
            NewCh;
          END; (*WHILE*)
          IF      identStr = 'SHOW' THEN
            curSy := showSy
          ELSE IF identStr = 'HIDE' THEN
            curSy := hideSy
          ELSE IF identStr = 'LINE' THEN
            curSy := lineSy
          ELSE IF identStr = 'RECTANGLE' THEN
            curSy := rectangleSy
          ELSE IF identStr = 'CIRCLE' THEN
            curSy := circleSy
          ELSE IF identStr = 'PICTURE' THEN
            curSy := pictureSy
          ELSE IF identStr = 'MOVE' THEN
            curSy := moveSy
          ELSE
            curSy := identSy;
        END;
        '0'..'9': begin
                (* read a number *)
                numVal := Ord(curCh) - Ord('0'); (* value of digit*)
                newCh;
                while (curCh >= '0') and (curCh <= '9') do begin
                    numVal := numVal * 10 + Ord(curCh) - Ord('0');
                    newCh;
                end;
                curSy := numberSy;
            end;
        else begin curSy := noSy; newCh; end; (* default case *)
    end; (* case *)
    writeln(curSy);
end;

procedure newCh;
begin
    if curChPos < length(line) then begin
        inc(curChPos);
        curCh := line[curChPos]
    end else begin
        readLn(inFile, line);
        writeLn('LINE LENGTH', length(line));
        if(length(line) = 0) then
            curCh := EOF_CH
        else begin
            curChPos := 0;
            inc(curChPos);
            curCh := line[curChPos]
        end;
    end;
end;

begin
end.
