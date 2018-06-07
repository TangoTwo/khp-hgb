(* WordCounter:                                  HDO, 2003-02-28 *)
(* -----------                                                   *)
(* Template for programs that count words in text files.         *)
(*===============================================================*)
PROGRAM WordCounter;

  USES
    Timer, WordReader, ModBinarySearchTree;

VAR
    c, maxC : integer;
    mostFreqWord : string;
    w: Word;
    n: LONGINT;

BEGIN (*WordCounter*)
    init();
    WriteLn('WordCounter:');
    OpenFile('Kafka.txt', toLower);
  StartTimer;
  n := 0;
  maxC := 0;
  ReadWord(w);
  WHILE w <> '' DO BEGIN
      n := n + 1;
    c := addOrInc(w);
    if c > maxC then begin
            maxC := c;
            mostFreqWord := w;
    end;
    ReadWord(w);
  END; (*WHILE*)
  StopTimer;
  CloseFile;
  WriteLn('number of words: ', n);
  WriteLn('elapsed time:    ', ElapsedTime);
  writeLn('Most frequent word ', mostFreqWord, ' ', maxC);

END. (*WordCounter*)
