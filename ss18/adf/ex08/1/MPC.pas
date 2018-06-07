(* MPP:                                          HDO, 2004-02-06
   ----
   MiniPascal Parser (basis for interpreter and compiler).
================================================================*)
PROGRAM MPC;

  USES
    MP_Lex, MPC_SS, CodeDef, CodeGen, CodeInt;

  VAR
  srcName, destName: STRING;
  ca: CodeArray;
    ok: BOOLEAN;

BEGIN (*MP_P*)

    WriteLn('MPC: MidiPascal Compila');
    If ParamCount <> 1 THEN BEGIN
        WriteLn('Usage: MPC <input.mp>');
        HALT;
    END;
    srcName := ParamStr(1);
    InitScanner(srcName, ok);

    S;
    WriteLn('Success: ', success);

    IF success THEN BEGIN
        GetCode(ca);
        destName := srcName + 'c';
        StoreCode(destName, ca);

        LoadCode(destName, ca, ok);
        InterpretCode(ca);
    END;
END. (*MPP*)
