PROGRAM test;
  VAR
    a, b: INTEGER;
BEGIN
  READ(a);
  READ(b);

  IF a THEN BEGIN
    WRITE(a);
  END
  ELSE BEGIN
     WRITE(b);
  END;

END.
