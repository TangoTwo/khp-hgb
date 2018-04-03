(* WordCounter:                                  HDO, 2003-02-28 *)
(* -----------                                                   *)
(* Template for programs that count words in text files.         *)
(*===============================================================*)
PROGRAM WordCounter;

  USES WordReader, md5;

VAR
    c, maxC : integer;
    mostFreqWord : string;
    w: Word;
    n: LONGINT;

BEGIN (*WordCounter*)
  ReadWord(w);
  WHILE w <> '' DO BEGIN
    ReadWord(w);
  END; (*WHILE*)

END. (*WordCounter*)
