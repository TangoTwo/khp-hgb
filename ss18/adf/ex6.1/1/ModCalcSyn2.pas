unit ModCalcSyn2;

interface
var
    success : boolean;
procedure S;

implementation
uses ModCalcLex, sysutils;

type
    nodePtr = ^Node;
    node = record
               firstChild, sibling : nodePtr;
               val : string; (* nonterminal, operator or operand as text *)
           end;
    treePtr = nodePtr;

procedure expr(var ePtr : treePtr); forward;
procedure term(var tPtr : treePtr); forward;
procedure fact(var fPtr : treePtr); forward;

procedure S;
var exprPtr : treePtr;
begin
    new(exprPtr);
    (* S = expr EOF. *)
    success := TRUE;
    expr(exprPtr); if not success then exit;
    if curSy <> eofSy then begin success := FALSE; exit; end;
    newSy;
    (* sem *)
    write(exprPtr^.val);
    (* endsem *)
end;

procedure expr(var ePtr : treePtr);
var firstChildPtr : treePtr;
    siblingPtr : treePtr;
begin
    new(firstChildPtr);
    new(siblingPtr);
    (* Expr = Term { '+' Term | '-' Term } *)
    term(firstChildPtr); if not success then exit;
    while (curSy = plusSy) or (curSy = minusSy) do begin
        case curSy of
            plusSy: begin
                    newSy;
                    term(siblingPtr); if not success then exit;
                    (* sem *)
                    ePtr^.val := '+';
                    ePtr^.firstChild := firstChildPtr;
                    ePtr^.sibling := siblingPtr;
                    (* endsem *)
                end;
            minusSy: begin
                     newSy;
                     term(siblingPtr); if not success then exit;
                     (* sem *)
                     ePtr^.val := '-';
                     ePtr^.firstChild := firstChildPtr;
                     ePtr^.sibling := siblingPtr;
                     (* endsem *)
                end;
        end; (* case *)
    end; (* while *)
end;

procedure term(var tPtr : treePtr);
var firstChildPtr : treePtr;
    siblingPtr : treePtr;
begin
    new(firstChildPtr);
    new(siblingPtr);
    (* Term = Fact { '*' Fact | '/' Fact }. *)
    fact(firstChildPtr); if not success then exit;
    while (curSy = mulSy) or (curSy = divSy) do begin
        case curSy of
            mulSy: begin
                    newSy;
                    fact(siblingPtr); if not success then exit;
                    (* sem *)
                    tPtr^.val := '*';
                    tPtr^.firstChild := firstChildPtr;
                    tPtr^.sibling := siblingPtr;
                    (* endsem *)
                end;
            divSy: begin
                    newSy;
                    fact(siblingPtr); if not success then exit;
                     (* sem *)
                    tPtr^.val := '*';
                    tPtr^.firstChild := firstChildPtr;
                    tPtr^.sibling := siblingPtr;
                    (* endsem *)
                end;
        end; (* case *)
    end; (* while *)
end;

procedure fact(var fPtr : treePtr);
begin
    (* Fact = number | '(' Expr ')' . *)
    case curSy of
        numberSy : begin 
                newSy; 
                (* sem *)
                fPtr^.val := intToStr(numVal);
                (* endsem *)
            end;
        leftParSy : begin
                newSy; (* skip (*)
                expr(fPtr); if not success then exit;
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
