(* MPP:                                          HDO, 2004-02-06
   ----
   MiniPascal Parser (basis for interpreter and compiler).
================================================================*)
PROGRAM MPVM;

  USES
    CodeDef, CodeInt;

  VAR
  fileName: STRING;
  ca: CodeArray;
    ok: BOOLEAN;

BEGIN (*MP_P*)

    WriteLn('MPVM: MiniPascal Virtual Machine');
    If ParamCount <> 1 THEN BEGIN
        WriteLn('Usage: MPVM <program.mpc>');
        HALT;
    END;
    fileName := ParamStr(1);
    LoadCode(fileName, ca, ok);
    InterpretCode(ca);
END. (*MPP*)
