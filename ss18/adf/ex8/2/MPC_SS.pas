(* MPP_SS:                                          HDO, 2004-02-06
   ------
   Syntax analyzer and semantic evaluator for the MiniPascal parser.
   Semantic actions to be included in MPI_SS and MPC_SS.
===================================================================*)
UNIT MPC_SS;

INTERFACE

  VAR
  success: BOOLEAN; (*true if no syntax errros*)

  PROCEDURE S;        (*parses whole MiniPascal program*)


IMPLEMENTATION

  USES
    MP_Lex, SymTab, CodeDef, CodeGen, BinTree;


  FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;
  BEGIN
    success:= success AND (sy = expectedSy);
    SyIsNot := NOT success;
  END; (*SyIsNot*)

PROCEDURE SemErr(msg: STRING);
BEGIN
    WriteLn('*** Semantic error ***');
    WriteLn('    ', msg);
    success := FALSE;
end;


  PROCEDURE MP(var binaryTree: TreePtr);      FORWARD;
  PROCEDURE VarDecl; FORWARD;
  PROCEDURE StatSeq(var binaryTree: TreePtr); FORWARD;
  PROCEDURE Stat(var binaryTree: TreePtr);    FORWARD;
  PROCEDURE Expr(var binaryTree: TreePtr);    FORWARD;
  PROCEDURE Term(var binaryTree: TreePtr);    FORWARD;
  PROCEDURE Fact(var binaryTree: TreePtr);    FORWARD;
  PROCEDURE EmitCodeForExprTree(t: TreePtr);  FORWARD;
  PROCEDURE Simplify(var t: TreePtr);           FORWARD;
  PROCEDURE ConstantFolding(var t: TreePtr);  FORWARD;


  PROCEDURE S;
(*-----------------------------------------------------------------*)
VAR
    binaryTree: TreePtr;
BEGIN
    binaryTree := newTree('');
    WriteLn('parsing started ...');
    success := TRUE;
    MP(binaryTree);
    IF NOT success OR SyIsNot(eofSy) THEN
      WriteLn('*** Error in line ', syLnr:0, ', column ', syCnr:0)
    ELSE
        WriteLn('... parsing ended successfully ');
    Simplify(binaryTree);
    ConstantFolding(binaryTree);
    writeTreeInOrder(binaryTree);
  END; (*S*)

  PROCEDURE MP(var binaryTree: TreePtr);
  BEGIN
      IF SyIsNot(programSy) THEN Exit;
      (* sem *)
      initSymbolTable;
      InitCodeGenerator;
      (* endsem *)
    NewSy;
    IF SyIsNot(identSy) THEN Exit;
    NewSy;
    IF SyIsNot(semicolonSy) THEN Exit;
    NewSy;
    IF sy = varSy THEN BEGIN
      VarDecl; IF NOT success THEN Exit;
    END; (*IF*)
    IF SyIsNot(beginSy) THEN Exit;
    NewSy;
    StatSeq(binaryTree); IF NOT success THEN Exit;
    (* sem *)
    EmitCodeForExprTree(binaryTree);
    Emit1(EndOpc);
    (* endsem *)
    IF SyIsNot(endSy) THEN Exit;
    NewSy;
    IF SyIsNot(periodSy) THEN Exit;
    NewSy;
  END; (*MP*)

PROCEDURE VarDecl;
var ok : BOOLEAN;
  BEGIN
    IF SyIsNot(varSy) THEN Exit;
    NewSy;
    IF SyIsNot(identSy) THEN Exit;
    (* sem *)
      DeclVar(identStr, ok);
    NewSy;
    WHILE sy = commaSy DO BEGIN
      NewSy;
      IF SyIsNot(identSy) THEN Exit;
      (* sem *)
      DeclVar(identStr, ok);
      IF NOT ok THEN
          SemErr('mult. decl.');
      (* endsem *)
      NewSy;
    END; (*WHILE*)
    IF SyIsNot(colonSy) THEN Exit;
    NewSy;
    IF SyIsNot(integerSy) THEN Exit;
    NewSy;
    IF SyIsNot(semicolonSy) THEN Exit;
    NewSy;
  END; (*VarDecl*)

PROCEDURE StatSeq(var binaryTree: TreePtr);
  BEGIN
    Stat(binaryTree); IF NOT success THEN Exit;
    WHILE sy = semicolonSy DO BEGIN
      NewSy;
      Stat(binaryTree); IF NOT success THEN Exit;
    END; (*WHILE*)
  END; (*StatSeq*)

PROCEDURE Stat(var binaryTree: TreePtr);
var destId : STRING;
    addr, addr1, addr2 : integer;
  BEGIN
    CASE sy OF
        identSy: BEGIN
                (* sem *)
          destId := identStr;
          IF NOT IsDecl(destId) THEN
              SemErr('var. not decl.')
          ELSE
              Emit2(LoadAddrOpc, AddrOf(destId));
          (* endsem *)
          NewSy;
          IF SyIsNot(assignSy) THEN Exit;
          NewSy;
          Expr(binaryTree); IF NOT success THEN Exit;
          (* sem *)
          IF IsDecl(destId) THEN
              Emit1(StoreOpc);
          (* endsem *)
        END;
      readSy: BEGIN
          NewSy;
          IF SyIsNot(leftParSy) THEN Exit;
          NewSy;
          IF SyIsNot(identSy) THEN Exit;
          (* sem *)
          IF NOT IsDecl(identStr) THEN
              SemErr('var not decl.')
          ELSE BEGIN
              Emit2(ReadOpc,AddrOf(identStr));
          END;
          (* endsem *)
          NewSy;
          IF SyIsNot(rightParSy) THEN Exit;
          NewSy;
        END;
      writeSy: BEGIN
          NewSy;
          IF SyIsNot(leftParSy) THEN Exit;
          NewSy;
          Expr(binaryTree); IF NOT success THEN Exit;
          (* sem *)
          Emit1(WriteOpc);
          (* endsem *)
          IF SyIsNot(rightParSy) THEN Exit;
          NewSy;
          END;
        beginSy: BEGIN
                newSy;
                StatSeq(binaryTree);
                IF SyIsNot(endSy) THEN Exit;
                NewSy;
            END;
        ifSy: BEGIN
                NewSy;
                IF SyIsNot(identSy) THEN Exit;
                (* SEM *)
                IF NOT IsDecl(identStr) THEN BEGIN
                    SemErr('var not decl.');
                END;
                Emit2(LoadValOpc, AddrOf(identStr));
                Emit2(JmpZOpc, 0); (*0 as dummy address*)
                addr := CurAddr - 2;
                (* ENDSEM *)
                NewSy;
                IF SyIsNot(thenSy) THEN Exit;
                newSy;
                Stat(binaryTree); IF NOT success THEN Exit;
                IF sy = elseSy THEN BEGIN
                    newSy;
                    (* SEM *)
                    Emit2(JmpOpc, 0);
                    FixUp(addr, CurAddr);
                    addr := CurAddr - 2;
                    (* ENDSEM *)
                    Stat(binaryTree); IF NOT success THEN Exit;
                END;
                (* SEM *)
                FixUp(addr, CurAddr);
                (* ENDSEM *)
            END;
        whileSy: BEGIN
                NewSy;
                IF SyIsNot(identSy) THEN Exit;
                (* SEM *)
                IF NOT IsDecl(identStr) THEN BEGIN
                    SemErr('var not decl.');
                END;
                addr1 := CurAddr;
                Emit2(LoadValOpc, AddrOf(identStr));
                Emit2(JmpZOpc, 0); (*0 as dummy address*)
                addr2 := CurAddr - 2;
                (* ENDSEM *)
                NewSy;
                IF SyIsNot(doSy) THEN Exit;
                NewSy;
                Stat(binaryTree);
                (* SEM *)
                Emit2(JmpOpc, addr1);
                FixUp(addr2, CurAddr);
                (* ENDSEM *)
            END;
      ELSE
       ; (*EPS*)
    END; (*CASE*)
  END; (*Stat*)

PROCEDURE Expr(var binaryTree: TreePtr);
var t: TreePtr;
  BEGIN
    Term(binaryTree); IF NOT success THEN Exit;
    WHILE (sy = plusSy) OR (sy = minusSy) DO BEGIN
        CASE sy OF
          plusSy: BEGIN
              NewSy;
              Term(binaryTree^.right); IF NOT success THEN Exit;
              (* sem *)
              t := newTree('+');
              t^.left := binaryTree;
              t^.right := newTree('');
              binaryTree := t;
              (* endsem *)
            END;
          minusSy: BEGIN
              NewSy;
              Term(binaryTree^.right); IF NOT success THEN Exit;
              (* sem *)
              t := newTree('-');
              t^.left := binaryTree;
              t^.right := newTree('');
              binaryTree := t;
              (* endsem *)
            END;
        END; (*CASE*)
      END; (*WHILE*)
  END; (*Expr*)

PROCEDURE Term(var binaryTree: TreePtr);
var t: TreePtr;
  BEGIN
    Fact(binaryTree); IF NOT success THEN Exit;
    WHILE (sy = timesSy) OR (sy = divSy) DO BEGIN
        CASE sy OF
          timesSy: BEGIN
              NewSy;
              Fact(binaryTree^.right); IF NOT success THEN Exit;
              (* sem *)
              t := newTree('*');
              t^.left := binaryTree;
              t^.right := newTree('');
              binaryTree := t;
              (* endsem *)
            END;
          divSy: BEGIN
               NewSy;
               Fact(binaryTree^.right); IF NOT success THEN Exit;
               (* sem *)
              t := newTree('/');
              t^.left := binaryTree;
              t^.right := newTree('');
              binaryTree := t;
              (* endsem *)
            END;
        END; (*CASE*)
      END; (*WHILE*)
  END; (*Term*)

PROCEDURE Fact(var binaryTree: TreePtr);
var t: TreePtr;
  BEGIN
    CASE sy OF
        identSy: BEGIN
                (* sem *)
                t := newTree(identStr);
                t^.left := binaryTree;
                t^.right := newTree('');
                binaryTree := t;
              (* endsem *)
              NewSy;
        END;
        numberSy: BEGIN
              (* sem *)
              t := newTree(numberVal);
                t^.left := binaryTree;
                t^.right := newTree('');
                binaryTree := t;
              (* endsem *)
              NewSy;
        END;
      leftParSy: BEGIN
          NewSy;
          Expr(binaryTree); IF NOT success THEN Exit;
          IF SyIsNot(rightParSy) THEN Exit;
          NewSy;
        END;
       ELSE
         success := FALSE;
    END; (*CASE*)
  END; (*Fact*)

PROCEDURE EmitCodeForExprTree(t: TreePtr);
var tVal : string;
    i, code : integer;
    opChar: char;
begin
    if(t <> NIL) then begin
        EmitCodeForExprTree(t^.left);
        tVal := t^.val;
        val(tVal, i, code);
        if(code = 0) then
            Emit2(LoadConstOpc,i)
        else
            if(length(tVal) > 1) then begin
                IF NOT IsDecl(identStr) THEN
                  SemErr('var. not decl.')
                ELSE
                  Emit2(LoadValOpc,AddrOf(identStr));
            end else begin
                opChar := tVal[1];
                CASE opChar OF
                    '+': BEGIN
                            Emit1(AddOpc);
                        END;
                    '-': BEGIN
                            Emit1(SubOpc);
                        END;
                    '*': BEGIN
                            Emit1(MulOpc);
                        END;
                    '/': BEGIN
                            Emit1(DivOpc);
                        END;
                    ELSE BEGIN
                            IF NOT IsDecl(identStr) THEN
                                SemErr('var. not decl.')
                            ELSE
                                Emit2(LoadValOpc,AddrOf(identStr));
                        END;
                END;
            end;
        EmitCodeForExprTree(t^.right);
    end;
end;

procedure Simplify(var t: TreePtr);
var tVal : string;
    i, code : integer;
    opChar: char;
begin
    if(t <> NIL) then begin
        Simplify(t^.left);
        Simplify(t^.right);
        tVal := t^.val;
        val(tVal, i, code);
        if((code <> 0) and (length(tVal) = 1)) then begin
            opChar := tVal[1];
            CASE opChar OF
                '+': BEGIN
                        if(t^.left^.val = '0') then
                            t := t^.right
                        else if(t^.right^.val = '0') then
                            t := t^.left;
                    END;
                '-': BEGIN
                        if(t^.left^.val = '0') then
                            t := t^.right
                        else if(t^.right^.val = '0') then
                            t := t^.left;
                    END;
                '*': BEGIN
                        if(t^.left^.val = '1') then
                            t := t^.right
                        else if(t^.right^.val = '1') then
                            t := t^.left;
                    END;
                '/': BEGIN
                        if(t^.left^.val = '1') then
                            t := t^.right
                        else if(t^.right^.val = '1') then
                            t := t^.left;
                    END;
                ELSE BEGIN
                    IF NOT IsDecl(identStr) THEN
                        SemErr('var. not decl.')
                    ELSE
                        Emit2(LoadValOpc,AddrOf(identStr));
                END;
            END;      
        end;
    end;
end;

procedure ConstantFolding(var t: TreePtr);
var tValLeft,tValRight : string;
    valString: string;
    iLeft,iRight, codeLeft, codeRight : integer;
    opChar: char;
begin
    if(t <> NIL) then begin
        valString := '';
        ConstantFolding(t^.left);
        ConstantFolding(t^.right);
        if(t^.left <> NIL) and (t^.right <> NIL) then begin
            tValLeft := t^.left^.val;
            tValRight := t^.right^.val;
            val(tValLeft, iLeft, codeLeft);
            val(tValRight, iRight, codeRight);
            if(codeLeft = 0) and (codeRight = 0) then begin
                opChar := t^.val[1];
                CASE opChar OF
                    '+': BEGIN
                            Str(iLeft + iRight, valString);
                        END;
                    '-': BEGIN
                            Str(iLeft - iRight, valString);
                        END;
                    '*': BEGIN
                            Str(iLeft * iRight, valString);
                        END;
                    '/': BEGIN
                            Str(iLeft DIV iRight, valString);
                        END;
                END;
                t^.val := valString;
            end;
        end;
    end;
end;

    BEGIN
END. (*MPP_SS*)
