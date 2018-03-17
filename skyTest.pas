PROGRAM skyTest;
USES ModLCGRandom, ptcgraph;

var
    gd, gm, lo, hi, error, tw, th : integer;
    found : boolean;

BEGIN
    gd := D8bit;
    gm := m640x480;
    initgraph(gd,gm,'');
    error := graphResult;
    if(error <> grOk) Then
    begin
        writeln('ERORRORORORO');
    end;
    setColor(black);
    rectangle(0,0,getmaxx,getmaxy);
    { Write a nice message in the center of the screen }
    setTextStyle(defaultFont,horizDir,1);
    tw:=TextWidth(TheLine);
    th:=TextHeight(TheLine);
    outTextXY((getMaxX - TW) div 2,
        (getMaxY - TH) div 2,TheLine);
    { Wait for return }
    readln;
    { Back to text mode }
    closegraph;
END.
