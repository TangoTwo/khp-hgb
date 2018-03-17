program statistics;
uses ModLCGRandom;

(*interface
procedure ComputeRuns( n : integer;
                       var maxAsc, maxDesc : integer;
                       var asc, desc : intArray);*)

type
    intArray = array[integer] of 1..20;
    
var h : integer;
    n : integer;
    hOld : integer;
    curRun : integer;
    i : integer;
    asc, desc : intArray;
    maxAsc, maxDesc : integer;

procedure ComputeRuns(n : integer;
                      var maxAsc, maxDesc : integer;
                      var asc, desc : intArray);
begin
    h := 1337; (*Seed value*)
    i := 0;
    hOld := h;
    curRun := 0;
    repeat
        initLCG(h);
        h := RandInt;
        if i = 0 then
            hOld := h; (*So first run isn't counted*)
        if h > hOld then(*Means run is now ascending*)
        begin
            if curRun >= 0 then(*current run is ascending or just started*)
            begin
                inc(curRun);
            end
            else if curRun < 0 then(*current run is descending*)
            begin
                dec(curRun); (*Because else the run will always display one short*)
                if -curRun > maxDesc then
                begin
                    maxDesc := -curRun;
                end;
                inc(desc[-curRun]);
                curRun := 1;
            end;
        end
        else if h < hOld then(*means run is now descending*)
        begin
            if curRun <= 0 then(*current run is descending or just started*)
            begin
                dec(curRun);
            end
            else if curRun > 0 then(*current run is ascending*)
            begin
                inc(curRun);  (*Because else the run will always display one short*)
                if curRun > maxAsc then (*new record asc!*)
                begin
                    maxAsc := curRun;
                end;
                inc(asc[curRun]);
                curRun := -1;
            end;
        end
        else (*current number is same as the one before*)
        begin
            if curRun > 0 then(*current run is ascending*)
            begin
                inc(curRun);  (*Because else the run will always display one short*)
                if curRun > maxAsc then (*new record asc!*)
                begin
                    maxAsc := curRun;
                end;
                inc(asc[curRun]);
                curRun := 0;
            end
            else if curRun < 0 then(*current run is descending*)
            begin
                dec(curRun);  (*Because else the run will always display one short*)
                if -curRun > maxDesc then
                begin
                    maxDesc := -curRun;
                end;
                inc(desc[-curRun]);
                curRun := 0;
            end; 
        end;
        writeLn(h);
        writeLn('Current Index = ', curRun);
        inc(i);
        hOld := h;
    until i = n;
    writeLn('### Statistics ###');
    writeLn('Maximum Ascend:', maxAsc);
    writeLn('Maximum Descend:', maxDesc);
    writeLn('Maximum Ascend happened:', asc[maxAsc]);
    writeLn('Maximum Descend happened:', desc[maxDesc]);
end;
begin
    n := 20;
    ComputeRuns(n, maxAsc, maxDesc, asc, desc);
end.
