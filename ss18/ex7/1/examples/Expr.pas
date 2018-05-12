(* parsing functions generated from file 'Expr.syn' *)

  FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;
  BEGIN
    success:= success AND (sy = expectedSy);
    SyIsNot := NOT success;
  END; (*SyIsNot*)

  PROCEDURE Expr;
  BEGIN
    Term; IF NOT success THEN Exit;
    WHILE sy = ... DO BEGIN
      IF SyIsNot(plusSy) THEN Exit;
      NewSy;
      Term; IF NOT success THEN Exit;
    END; (*WHILE*)
  END; (*Expr*)

  PROCEDURE Term;
  BEGIN
    Fact; IF NOT success THEN Exit;
    WHILE sy = ... DO BEGIN
      IF SyIsNot(timesSy) THEN Exit;
      NewSy;
      Fact; IF NOT success THEN Exit;
    END; (*WHILE*)
  END; (*Term*)

  PROCEDURE Fact;
  BEGIN
    IF sy = ... THEN BEGIN
      IF SyIsNot(numberSy) THEN Exit;
      NewSy;
    END (*IF*)
    ELSE IF sy = ... THEN BEGIN
      IF SyIsNot(leftParSy) THEN Exit;
      NewSy;
      Expr; IF NOT success THEN Exit;
      IF SyIsNot(rightParSy) THEN Exit;
      NewSy;
    END (*IF*)
    ELSE
      success := FALSE;
  END; (*Fact*)

(* generation ended succesfully *)
