unit ParseGen_Syn;

interface
var
    success : boolean;

procedure Grammar; (* entry for recursive descent parser *)

implementation
uses ParseGen_Lex, FileWriter;

procedure Rule; FORWARD;
procedure Expr; FORWARD;
procedure Term; FORWARD;
procedure Fact; FORWARD;

FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;
BEGIN
    IF sy <> expectedSy THEN success := FALSE;
    SyIsNot := success;
END; (*SyIsNot*)

procedure Grammar;
begin
    (* SEM *)
    writeToFile('FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;',0);
    writeToFile('BEGIN',1);
    writeToFile('success := success AND (sy = expectedSy);',0);
    writeToFile('SyIsNot := NOT success;',0);
    writeToFile('END; (*SyIsNot*)',-1);
    writeToFile('',0);
    (* ENDSEM *)
    rule; IF NOT success THEN Exit;
    WHILE sy <> identSy DO BEGIN
        rule; IF NOT success THEN Exit;
    END; (*WHILE*)
end;

PROCEDURE rule;
var tString : string;
BEGIN
    
   IF SyIsNot(identSy) THEN EXIT;
   newSy;
   (* SEM *)
   writeToFile('',0);
   tString := 'PROCEDURE ' + identStr + ';';
   writeToFile(tString,0);
   writeToFile('BEGIN',1);
   IF SyIsNot(equalSy) THEN EXIT;
   newSy;
   expr; IF NOT success THEN Exit;
   (* SEM *)
   writeToFile('END;', -1);
END; (*rule*)

PROCEDURE expr;
BEGIN
   IF sy = ltSy THEN BEGIN
      IF SyIsNot(ltSy) THEN EXIT;
      newSy;
      (* SEM *)
      writeToFile('IF sy = ... THEN BEGIN',1);
      (* ENDSEM *)
      term; IF NOT success THEN Exit;
      (* SEM *)
      writeToFile('END;', -1);
      WHILE sy = barSy DO BEGIN
         IF SyIsNot(barSy) THEN EXIT;
         newSy;
         (* SEM *)
         writeToFile('ELSE IF sy = ... THEN BEGIN',-1);
         (* ENDSEM *)
         term; IF NOT success THEN Exit;
         (* SEM *)
         writeToFile('END;',-1);
         (* ENDSEM *)
      END; (*WHILE*)
      IF SyIsNot(gtSy) THEN EXIT;
      newSy;
      (* SEM *)
      writeToFile('ELSE success := FALSE;', -1);
      (* ENDSEM *)
   END (*IF*)
   ELSE
    term; IF NOT success THEN Exit;
END; (*expr*)

PROCEDURE term;
BEGIN
   fact; IF NOT success THEN Exit;
   WHILE sy <> identSy DO BEGIN
      fact; IF NOT success THEN Exit;
   END; (*WHILE*)
END; (*term*)

PROCEDURE fact;
var tString : string;
BEGIN
   IF sy = identSy THEN BEGIN
       IF SyIsNot(identSy) THEN EXIT;
       (* SEM *)
       tString := 'IF SyIsNot(' + identStr + 'Sy) THEN Exit;';
       writeToFile(tString, 0);
       tString := 'NewSy;';
       writeToFile(tString, 0);
         (* ENDSEM *)
      newSy;
   END (*IF*)
   ELSE IF sy = leftParSy THEN BEGIN
      IF SyIsNot(leftParSy) THEN EXIT;
      newSy;
      expr; IF NOT success THEN Exit;
      IF SyIsNot(rightParSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE IF sy = leftOptSy THEN BEGIN
      IF SyIsNot(leftOptSy) THEN EXIT;
      newSy;
      expr; IF NOT success THEN Exit;
      IF SyIsNot(rightOptSy) THEN EXIT;
      newSy;
   END (*IF*)
   ELSE IF sy = leftIterSy THEN BEGIN
       (* SEM *)
       writeToFile('WHILE sy = ... DO BEGIN',1);
       (* ENDSEM *)
      IF SyIsNot(leftIterSy) THEN EXIT;
      newSy;
      expr; IF NOT success THEN Exit;
      IF SyIsNot(rightIterSy) THEN EXIT;
      (* SEM *)
      writeToFile('END;',-1);
      (* ENDSEM *)
      newSy;
   END (*IF*)
   ELSE
   success := FALSE;
END; (*fact*)

begin
end.
