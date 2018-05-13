(* parsing functions generated from file './examples/Expr.syn' *)

FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;
BEGIN
   success := success AND (sy = expectedSy);
   SyIsNot := NOT success;
END; (*SyIsNot*)

PROCEDURE expr;
BEGIN
   term; IF NOT success THEN Exit;
   WHILE sy = ... DO BEGIN
      IF SyIsNot(plusSy) THEN EXIT;
      newSy;
      term; IF NOT success THEN Exit;
   END; (*WHILE*)
END; (*expr*)

PROCEDURE term;
BEGIN
   fact; IF NOT success THEN Exit;
   WHILE sy = ... DO BEGIN
      IF SyIsNot(mulSy) THEN EXIT;
      newSy;
      fact; IF NOT success THEN Exit;
   END; (*WHILE*)
END; (*term*)

PROCEDURE fact;
BEGIN
   IF sy = ... THEN BEGIN
      IF SyIsNot(numberSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE IF sy = ... THEN BEGIN
      IF SyIsNot(leftParSy) THEN EXIT;
      newSy;
      expr; IF NOT success THEN Exit;
      IF SyIsNot(rightParSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE
   success := FALSE;
END; (*fact*)

(* generation ended successfully *)
