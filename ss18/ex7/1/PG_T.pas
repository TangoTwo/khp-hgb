unit MPI_SynT;

interface
var
    success : boolean;

procedure s; (* entry for recursive descent parser *)

implementation
uses MP_Lex;

procedure S;
begin
    success := TRUE;
    while(sy <> eofSy) do begin
        newSy;
        if(sy <> nonTermSy) and (sy <> termSy) then
            writeLn(sy)
        else
            writeLn(sy, '=', stringVal);
        if(sy = noSy) then begin
            success := FALSE;
            exit;
        end;
    end;
end;

begin
end.
