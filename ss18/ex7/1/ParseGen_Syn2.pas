unit ParseGen_Syn;

interface
var
    success : boolean;

procedure Grammar; (* entry for recursive descent parser *)

implementation
uses ParseGen_Lex, FileWriter;

procedure Rule(var r : string); FORWARD;
procedure Expr(var e : string); FORWARD;
procedure Term(var t : string); FORWARD;
procedure Fact(var f : string); FORWARD;

function syIsNot(expected : symbol) : boolean;
begin
    if sy <> expected then success := FALSE;
    SyIsNot := NOT success;
end;

procedure Grammar;
var r : string;
begin
    (* Grammar = Rule { Rule }. *)
    Rule(r); if not success then exit;
    while (sy <> nonTermSy) do begin
        Rule(r); if not success then exit;
    end;
end;

procedure Rule(var r : string);
var e : string;
begin
    if sy <> nonTermSy then begin success := FALSE; exit; end;
    newSy;
    if sy <> isSy then begin success := FALSE; exit; end;
    newSy;
    Expr(e); if not success then exit;
    if sy <> dotSy then begin success := FALSE; exit; end;
    newSy;
    writeln('END');
end;

procedure Expr(var e : string);
var t : string;
begin
    if(sy = arrowLeftSy) then begin
        Term(t); if not success then exit;
        while sy = barSy do begin
            Term(t); if not success then exit;
        end;
        if sy <> arrowRightSy then begin success := FALSE; exit; end;
    end else begin
        Term(t); if not success then exit;
    end;
end;

procedure Term(var t : string);
var f : string;
begin
    Fact(f); if not success then exit;
    while (sy <> nonTermSy) do begin
        Fact(f); if not success then exit;
    end;
end;

procedure Fact(var f : string);
begin
    success := TRUE;
    case sy of
        nonTermSy: begin
                newSy;
            end;
        leftParSy: begin
                newSy;
                Expr(f); if not success then exit;
                if sy <> rightParSy then begin success := FALSE; exit; end;
            end;
        leftSqBrSy: begin
                newSy;
                Expr(f); if not success then exit;
                if sy <> rightSqBrSy then begin success := FALSE; exit; end;
            end;
        leftCurlSy: begin
                newSy;
                Expr(f); if not success then exit;
                if sy <> rightCurlSy then begin success := FALSE; exit; end;
            end;
        else begin
            newSy;
        end;
    end;
end;

begin
end.
