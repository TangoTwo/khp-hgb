(* parsing functions generated from file './examples/EBNF.syn' *)

FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;
BEGIN
   success := success AND (sy = expectedSy);
   SyIsNot := NOT success;
END; (*SyIsNot*)

PROCEDURE grammar;
BEGIN
   rule; IF NOT success THEN Exit;
   WHILE sy = ... DO BEGIN
      rule; IF NOT success THEN Exit;
   END; (*WHILE*)
END; (*grammar*)

PROCEDURE rule;
BEGIN
   IF SyIsNot(identSy) THEN EXIT;
   newSy;
   IF SyIsNot(equalSy) THEN EXIT;
   newSy;
   expr; IF NOT success THEN Exit;
END; (*rule*)

PROCEDURE expr;
BEGIN
   IF sy = ... THEN BEGIN
      term; IF NOT success THEN Exit;
   END (*IF*)
   ELSE IF sy = ... THEN BEGIN
      IF SyIsNot(ltSy) THEN EXIT;
      newSy;
      term; IF NOT success THEN Exit;
      WHILE sy = ... DO BEGIN
         IF SyIsNot(barSy) THEN EXIT;
         newSy;
         term; IF NOT success THEN Exit;
      END; (*WHILE*)
      IF SyIsNot(gtSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE
   success := FALSE;
END; (*expr*)

PROCEDURE term;
BEGIN
   fact; IF NOT success THEN Exit;
   WHILE sy = ... DO BEGIN
      fact; IF NOT success THEN Exit;
   END; (*WHILE*)
END; (*term*)

PROCEDURE fact;
BEGIN
   IF sy = ... THEN BEGIN
      IF SyIsNot(identSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE IF sy = ... THEN BEGIN
      IF SyIsNot(leftParSy) THEN EXIT;
      newSy;
      expr; IF NOT success THEN Exit;
      IF SyIsNot(rightParSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE IF sy = ... THEN BEGIN
      IF SyIsNot(leftOptSy) THEN EXIT;
      newSy;
      expr; IF NOT success THEN Exit;
      IF SyIsNot(rightOptSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE IF sy = ... THEN BEGIN
      IF SyIsNot(leftIterSy) THEN EXIT;
      newSy;
      expr; IF NOT success THEN Exit;
      IF SyIsNot(rightIterSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE
   success := FALSE;
END; (*fact*)

(* generation ended successfully *)
