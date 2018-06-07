(* MPP_SS:                                          HDO, 2004-02-06
   ------
   Syntax analyzer and semantic evaluator for the MiniPascal parser.
   Semantic actions to be included in MPI_SS and MPC_SS.
===================================================================*)
UNIT MPP_SS;

INTERFACE

  VAR
    success: BOOLEAN; (*true if no syntax errros*)

  PROCEDURE S;        (*parses whole MiniPascal program*)


IMPLEMENTATION

  USES
    MP_Lex, SymTab;


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


  PROCEDURE MP;      FORWARD;
  PROCEDURE VarDecl; FORWARD;
  PROCEDURE StatSeq; FORWARD;
  PROCEDURE Stat;    FORWARD;
  PROCEDURE Expr(var e: INTEGER);    FORWARD;
  PROCEDURE Term(var t: INTEGER);    FORWARD;
  PROCEDURE Fact(var f: INTEGER);    FORWARD;

  PROCEDURE S;
(*-----------------------------------------------------------------*)
  BEGIN
    WriteLn('parsing started ...');
    success := TRUE;
    MP;
    IF NOT success OR SyIsNot(eofSy) THEN
      WriteLn('*** Error in line ', syLnr:0, ', column ', syCnr:0)
    ELSE
      WriteLn('... parsing ended successfully ');
  END; (*S*)

  PROCEDURE MP;
  BEGIN
      IF SyIsNot(programSy) THEN Exit;
      (* sem *)
      initSymbolTable;
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
    StatSeq; IF NOT success THEN Exit;
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
      IF NOT ok THEN
          SemErr('mult. decl.');
      (* endsem *)
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

PROCEDURE StatSeq;
  BEGIN
    Stat; IF NOT success THEN Exit;
    WHILE sy = semicolonSy DO BEGIN
      NewSy;
      Stat; IF NOT success THEN Exit;
    END; (*WHILE*)
  END; (*StatSeq*)

PROCEDURE Stat;
var destId : STRING;
    e : INTEGER;
  BEGIN
    CASE sy OF
        identSy: BEGIN
                (* sem *)
          destId := identStr;
          IF NOT IsDecl(destId) then
              SemErr('var. not decl.');
          (* endsem *)
          NewSy;
          IF SyIsNot(assignSy) THEN Exit;
          NewSy;
          Expr(e); IF NOT success THEN Exit;
          (* sem *)
          IF IsDecl(destId) THEN
              SetVal(destId, e);
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
          else begin
              Write(identStr, ' > ');
              ReadLn(e);
              SetVal(identStr, e);
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
          Expr(e); IF NOT success THEN Exit;
          (* sem *)
          WriteLn(e);
          (* endsem *)
          IF SyIsNot(rightParSy) THEN Exit;
          NewSy;
        END;
      ELSE
       ; (*EPS*)
    END; (*CASE*)
  END; (*Stat*)

PROCEDURE Expr(var e: INTEGER);
var t: INTEGER;
  BEGIN
    Term(t); IF NOT success THEN Exit;
    WHILE (sy = plusSy) OR (sy = minusSy) DO BEGIN
        CASE sy OF
          plusSy: BEGIN
              NewSy;
              Term(t); IF NOT success THEN Exit;
              (* sem *)
              e := e + t;
              (* endsem *)
            END;
          minusSy: BEGIN
              NewSy;
              Term(t); IF NOT success THEN Exit;
              (* sem *)
              e := e - t;
              (* endsem *)
            END;
        END; (*CASE*)
      END; (*WHILE*)
  END; (*Expr*)

PROCEDURE Term(var t: INTEGER);
var f : INTEGER;
  BEGIN
    Fact(f); IF NOT success THEN Exit;
    WHILE (sy = timesSy) OR (sy = divSy) DO BEGIN
        CASE sy OF
          timesSy: BEGIN
              NewSy;
              Fact(f); IF NOT success THEN Exit;
              (* sem *)
              t := t * f;
              (* endsem*)
            END;
          divSy: BEGIN
               NewSy;
               Fact(f); IF NOT success THEN Exit;
               (* sem *)
               IF f = 0 THEN
                   SemErr('zero division')
               else
                   t := t DIV f;
               (* endsem *)
            END;
        END; (*CASE*)
      END; (*WHILE*)
  END; (*Term*)

  PROCEDURE Fact(var f: INTEGER);
  BEGIN
    CASE sy OF
        identSy: BEGIN
                (* sem *)
              IF NOT IsDecl(identStr) THEN
                  SemErr('var. not decl.')
              ELSE
                  GetVal(identStr, f);
              (* endsem *)
              NewSy;
        END;
        numberSy: BEGIN
                (* sem*)
              f := numberVal;
              (* endsem *)
              NewSy;
        END;
      leftParSy: BEGIN
          NewSy;
          Expr(f); IF NOT success THEN Exit;
          IF SyIsNot(rightParSy) THEN Exit;
          NewSy;
        END;
       ELSE
         success := FALSE;
    END; (*CASE*)
  END; (*Fact*)


END. (*MPP_SS*)
