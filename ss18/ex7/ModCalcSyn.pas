unit ModCalcSyn;

interface
var
    success : boolean;
procedure S;

implementation
uses ModCalcLex;

procedure expr; forward;
procedure term; forward;
procedure fact; forward;

procedure S;
begin
    (* S = expr EOF. *)
    success := TRUE;
    expr; if not success then exit;
    if curSy <> eofSy then begin success := FALSE; exit; end;
    newSy;
end;

procedure expr;
begin
    (* Expr = Term { '+' Term | '-' Term } *)
    term; if not success then exit;
    while (curSy = plusSy) or (curSy = minusSy) do begin
        case curSy of
            plusSy: begin
                    newSy;
                    term; if not success then exit;
                end;
            minusSy: begin
                     newSy;
                     term; if not success then exit;
                end;
        end; (* case *)
    end; (* while *)
end;

procedure term;
begin
    (* Term = Fact { '*' Fact | '/' Fact }. *)
    fact; if not success then exit;
    while (curSy = mulSy) or (curSy = divSy) do begin
        case curSy of
            mulSy: begin
                    newSy;
                    fact; if not success then exit;
                end;
            divSy: begin
                    newSy;
                    fact; if not success then exit;
                end;
        end; (* case *)
    end; (* while *)
end;

procedure fact;
begin
    (* Fact = number | '(' Expr ')' . *)
    case curSy of
        numberSy : begin newSy; end;
        leftParSy : begin
                newSy; (* skip (*)
                expr; if not success then exit;
                if curSy <> rightParSy then begin success := FALSE; exit; end;
                newSy;
            end;
        else begin
            success := FALSE; exit;
        end;
    end;(* case *)
end;

begin
end.
