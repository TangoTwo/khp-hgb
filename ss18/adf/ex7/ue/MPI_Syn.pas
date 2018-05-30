unit MPI_Syn;

interface
var
    success : boolean;

procedure s; (* entry for recursive descent parser *)

implementation
uses MP_Lex;

procedure MP; forward;
procedure varDecl; forward;
procedure statSeq; forward;
procedure stat; forward;
procedure expr; forward;
procedure term; forward;
procedure fact; forward;

function syIsNot(expected : symbol) : boolean;
begin
    if sy <> expected then success := FALSE;
    SyIsNot := NOT success;
end;


procedure S;
begin
    success := TRUE;
    newSy;
    MP; if not success then exit;
    if sy <> eofSy then begin success := FALSE; exit; end;
end;

procedure MP;
begin
    (*
    while sy <> eofSy do begin
        writeLn(sy);
        newSy;
    end;
     *)
    if syIsNot(programSy) then exit;
    newSy;
    
    if syIsNot(idSy) then exit;
    newSy;
    
    if syIsNot(semicolonSy) then exit;
    newSy;

    (* [VarDecl] *)
    if sy = varSy then begin
        varDecl; if not success then exit;
    end;
    if syIsNot(beginSy) then exit;
    newSy;
    
    StatSeq; if not success then exit;
    
    if syIsNot(endSy) then exit;
    newSy;
    
    if syIsNot(dotSy) then exit;
    newSy;
    
end;

procedure varDecl; 
begin
    if syIsNot(varSy) then exit;
    newSy;

    if syIsNot(idSy) then exit;
    newSy;

    while sy = commaSy do begin
        NewSy; (* skip ',' *)
        if syIsNot(idSy) then exit;
        newSy;
    end;

    if syIsNot(colonSy) then exit;
    newSy;

    if syIsNot(integerSy) then exit;
    newSy;

    if syIsNot(semicolonSy) then exit;
    newSy;
end;

procedure statSeq; 
begin
    stat; if not success then exit;
    while sy = semicolonSy do begin
        newSy; (* skip ';' *)
        stat; if not success then exit;
    end;
end;

procedure stat; 
begin
    case sy of
        idSy : begin
                newSy; (* skip id *)
                if syIsNot(assignSy) then exit;
                newSy;
                Expr; if not success then exit;
            end;
        readSy: begin
                newSy; (* skip read *)
                if syIsNot(leftParSy) then exit;
                newSy;
                if syIsNot(idSy) then exit;
                newSy;
                if syIsNot(rightParSy) then exit;
                newSy;
            end;
        writeSy: begin
                newSy; (* skip write *)
                if syIsNot(leftParSy) then exit;
                newSy;
                expr; if not success then exit;
                if syIsNot(rightParSy) then exit;
                newSy;
            end;
    end; (* case *)
end;

procedure expr; 
begin
    term; if not success then exit;
    while (sy = plusSy) or (sy = minusSy) do begin
        if sy = plusSy then begin
            newSy; (* skip '+' *)
            term;  if not success then exit;
        end else if sy = minusSy then begin
            newSy; (* skip '-' *)
            term;  if not success then exit;
        end;
    end;
end;

procedure term; 
begin
    fact; if not success then exit;
    while (sy = mulSy) or (sy = divSy) do begin
        if sy = mulSy then begin
            newSy; (* skip '*' *)
            fact;  if not success then exit;
        end else if sy = divSy then begin
            newSy; (* skip '/' *)
            fact;  if not success then exit;
        end;
    end;
end;

procedure fact; 
begin
    case sy of
        idSy: begin newSy; end;
        numSy: begin newSy; end;
        leftParSy: begin
                newSy; (* skit '(' *)
                expr; if not success then exit;
                if syIsNot(rightParSy) then exit;
                newSy;
            end;
        else begin
            success := FALSE;
            exit;
        end;
    end; (* case *)
end;


begin
end.
