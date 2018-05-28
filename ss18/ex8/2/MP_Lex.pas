(* MP_Lex:                                          HDO, 2004-02-06
   -------
   Lexical analyzer (scanner) for the MiniPascal Interpreter and 
   the MiniPascal Compiler.
===================================================================*)
UNIT MP_Lex;

INTERFACE

  TYPE
    Symbol = (
      noSy, errSy, eofSy,
      beginSy, endSy, integerSy, programSy, readSy, varSy, writeSy,
      plusSy, minusSy, timesSy, divSy, leftParSy, rightParSy,
      commaSy, colonSy, assignSy, semicolonSy, periodSy,
      identSy, numberSy,
      ifSy, thenSy, elseSy,
      whileSy, doSy
    );

  VAR
    sy: Symbol;            (* current symbol *)
    syLnr, syCnr: INTEGER; (* start position of current symbol *)
    identStr: STRING;      (* string when sy = identSy  *)
    numberVal: STRING;    (* value  when sy = numberSy *)

  PROCEDURE InitScanner(srcName: STRING; VAR ok: BOOLEAN);

  PROCEDURE NewSy; (* updates sy, syLnr, syCnr and
                      when sy = identSy  then identStr or
                      when sy = numberSy then numberVal *)


IMPLEMENTATION

  CONST
    EF  = Chr(0);
    TAB = Chr(9);

  VAR
    srcFile: TEXT;
    srcLine: STRING;
    ch: CHAR;               (* current character *)
    chLnr, chCnr: INTEGER;  (* position of current character *)


  PROCEDURE NewCh;
  BEGIN
    IF chCnr < Length(srcLine) THEN BEGIN
      chCnr := chCnr + 1;
      ch := srcLine[chCnr]
    END (*THEN*)
    ELSE BEGIN
      IF NOT Eof(srcFile) THEN BEGIN
        ReadLn(srcFile, srcLine);
        chLnr:= chLnr + 1;
        chCnr := 0;
        ch := ' ';  (*to sparate two lines*)
      END (*THEN*)
      ELSE BEGIN
        Close(srcFile);
        ch := EF;
      END; (*ELSE*)
    END; (*ELSE*)
  END; (*NewCh*)


  PROCEDURE InitScanner(srcName: STRING; VAR ok: BOOLEAN);
(*-----------------------------------------------------------------*)
  BEGIN
    Assign(srcFile, srcName);
(*$I-*)
    Reset(srcFile);
(*$I+*)
    ok := IOResult = 0;
    IF ok THEN BEGIN
      srcLine := '';
      chLnr := 0;
      chCnr := 1;
      NewCh;
      NewSy;
    END; (*IF*)
  END; (*InitScanner*)



  PROCEDURE NewSy;
(*-----------------------------------------------------------------*)
  BEGIN
    WHILE (ch = ' ') OR (ch = TAB) DO BEGIN
      NewCh;
    END; (*WHILE*)
    syLnr := chLnr;
    syCnr := chCnr;
    CASE ch OF
      EF: BEGIN
          sy := eofSy;
        END;
      '+':  BEGIN
          sy := plusSy; NewCh;
        END;
      '-':  BEGIN
          sy := minusSy; NewCh;
        END;
      '*':  BEGIN
          sy := timesSy; NewCh;
        END;
      '/':  BEGIN
          sy := divSy; NewCh;
        END;
      '(':  BEGIN
          NewCh;
          sy := leftParSy;
        END;
      ')':  BEGIN
          sy := rightParSy; NewCh;
        END;
      ',':  BEGIN
          sy := commaSy; NewCh;
        END;
      ':':  BEGIN
          NewCh;
          IF ch <> '=' THEN
            sy := colonSy
          ELSE BEGIN (*ch = '='*)
            sy := assignSy; NewCh;
          END; (*ELSE*)
        END;
      ';':  BEGIN
          sy := semicolonSy; NewCh;
        END;
      '.':  BEGIN
          sy := periodSy; NewCh;
        END;
      'a'..'z', 'A'..'Z': BEGIN
          identStr := '';
          WHILE ch IN ['a'.. 'z', 'A' ..'Z', '0'..'9', '_'] DO BEGIN
            identStr := Concat(identStr, UpCase(ch));
            NewCh;
          END; (*WHILE*)
          IF      identStr = 'BEGIN' THEN
            sy := beginSy
          ELSE IF identStr = 'END' THEN
            sy := endSy
          ELSE IF identStr = 'INTEGER' THEN
            sy := integerSy
          ELSE IF identStr = 'PROGRAM' THEN
            sy := programSy
          ELSE IF identStr = 'READ' THEN
            sy := readSy
          ELSE IF identStr = 'VAR' THEN
            sy := varSy
          ELSE IF identStr = 'WRITE' THEN
              sy := writeSy
          ELSE IF identStr = 'IF' THEN
              sy := ifSy
          ELSE IF identStr = 'THEN' THEN
              sy := thenSy
          ELSE IF identStr = 'ELSE' THEN
              sy := elseSy
          ELSE IF identStr = 'WHILE' THEN
              sy := whileSy
          ELSE IF identStr = 'DO' THEN
              sy := doSy
          ELSE
            sy := identSy;
        END;
      '0'..'9':  BEGIN
          sy := numberSy;
          numberVal := ch;
          NewCh;
          WHILE ch IN ['0'..'9'] DO BEGIN
            numberVal := numberVal + ch;
            NewCh;
          END; (*WHILE*)
        END;
      ELSE (*default*)
        sy := errSy;
    END; (*CASE*)
  END; (*NewSy*)


END. (*MP_Lex*)
