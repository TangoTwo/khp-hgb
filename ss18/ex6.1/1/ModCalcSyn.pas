unit ModCalcSyn;

interface
var
    success : boolean;
procedure S;

implementation
uses ModCalcLex;

procedure expr(var e : integer); forward;
procedure term(var t : integer); forward;
procedure fact(var f : integer); forward;

procedure S;
var e : integer;
begin
    (* S = expr EOF. *)
    success := TRUE;
    expr(e); if not success then exit;
    if curSy <> eofSy then begin success := FALSE; exit; end;
    newSy;
    (* sem *)
    write(e);
    (* endsem *)
end;

procedure expr(var e : integer);
var t : integer;
begin
    (* Expr = Term { '+' Term | '-' Term } *)
    term(e); if not success then exit;
    while (curSy = plusSy) or (curSy = minusSy) do begin
        case curSy of
            plusSy: begin
                    newSy;
                    term(t); if not success then exit;
                    (* sem *)
                    e := e + t;
                    (* endsem *)
                end;
            minusSy: begin
                     newSy;
                     term(t); if not success then exit;
                     (* sem *)
                     e := e - t;
                     (* endsem *)
                end;
        end; (* case *)
    end; (* while *)
end;

procedure term(var t : integer);
var f : integer;
begin
    (* Term = Fact { '*' Fact | '/' Fact }. *)
    fact(t); if not success then exit;
    while (curSy = mulSy) or (curSy = divSy) do begin
        case curSy of
            mulSy: begin
                    newSy;
                    fact(f); if not success then exit;
                    (* sem *)
                    t := t * f;
                    (* endsem *)
                end;
            divSy: begin
                    newSy;
                    fact(f); if not success then exit;
                     (* sem *)
                    t := t div f;
                    (* endsem *)
                end;
        end; (* case *)
    end; (* while *)
end;

procedure fact(var f : integer);
begin
    (* Fact = number | '(' Expr ')' . *)
    case curSy of
        numberSy : begin 
                newSy; 
                (* sem *)
                f := numVal;
                (* endsem *)
            end;
        leftParSy : begin
                newSy; (* skip (*)
                expr(f); if not success then exit;
                if curSy <> rightParSy then begin success := FALSE; exit; end;
                newSy;
            end;
        else begin
            success := FALSE; exit;
        end; (* else *)
    end;(* case *)
end;

begin
end.
