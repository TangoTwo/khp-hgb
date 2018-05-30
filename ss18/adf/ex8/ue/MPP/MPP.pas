(* MPP:                                          HDO, 2004-02-06
   ----
   MiniPascal Parser (basis for interpreter and compiler).
================================================================*)
PROGRAM MPP;

  USES
    MP_Lex, MPP_SS;

  VAR
    srcName: STRING;
    ok: BOOLEAN;

BEGIN (*MP_P*)

  WriteLn('MPP: MiniPascal Parser');

  WHILE TRUE DO BEGIN
    WriteLn;
    Write('MiniPascal source file (*.mp) > ');
    ReadLn(srcName);
    IF Length(srcName) = 0 THEN
      Exit;

    InitScanner(srcName, ok);
    IF ok THEN
      S (*parsing*)
    ELSE
      WriteLn('... File not found');


  END; (*WHILE*)

END. (*MPP*)
