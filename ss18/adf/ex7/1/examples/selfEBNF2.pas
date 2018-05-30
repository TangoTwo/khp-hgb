(* parsing functions generated from file './examples/EBNF.syn' *)

FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;
BEGIN
   success := success AND (sy = expectedSy);
   SyIsNot := NOT success;
END; (*SyIsNot*)


PROCEDURE GRAMMAR;
BEGIN
   IF SyIsNot(RULESy) THEN Exit;
   NewSy;
   (* generation ended successfully *)
