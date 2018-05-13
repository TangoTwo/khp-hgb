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
               left, right : nodePtr;
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
var leftPtr : treePtr;
    rightPtr : treePtr;
begin
    new(leftPtr);
    new(rightPtr);
    (* Expr = Term { '+' Term | '-' Term } *)
    term(leftPtr); if not success then exit;
    while (curSy = plusSy) or (curSy = minusSy) do begin
        case curSy of
            plusSy: begin
                    newSy;
                    term(rightPtr); if not success then exit;
                    (* sem *)
                    ePtr^.val := '+';
                    ePtr^.left := leftPtr;
                    ePtr^.right := rightPtr;
                    (* endsem *)
                end;
            minusSy: begin
                     newSy;
                     term(siblingPtr); if not success then exit;
                     (* sem *)
                     ePtr^.val := '-';
                     ePtr^.left := leftPtr;
                     ePtr^.right := siblingPtr;
                     (* endsem *)
                end;
        end; (* case *)
    end; (* while *)
end;

procedure term(var tPtr : treePtr);
var leftPtr : treePtr;
    rightPtr : treePtr;
begin
    new(leftPtr);
    new(rightPtr);
    (* Term = Fact { '*' Fact | '/' Fact }. *)
    fact(leftPtr); if not success then exit;
    while (curSy = mulSy) or (curSy = divSy) do begin
        case curSy of
            mulSy: begin
                    newSy;
                    fact(rightPtr); if not success then exit;
                    (* sem *)
                    tPtr^.val := '*';
                    tPtr^.left := leftPtr;
                    tPtr^.right := rightPtr;
                    (* endsem *)
                end;
            divSy: begin
                    newSy;
                    fact(rightPtr); if not success then exit;
                     (* sem *)
                    tPtr^.val := '*';
                    tPtr^.left := leftPtr;
                    tPtr^.right := rightPtr;
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
