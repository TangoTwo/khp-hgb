(* WordCounter:                                  HDO, 2003-02-28 *)
(* -----------                                                   *)
(* Template for programs that count words in text files.         *)
(*===============================================================*)
PROGRAM WordCounter;

  USES WordReader, ModStringHash, ModHash2, ModHash3, graph;
const
    M = 2000;
VAR
    i : integer;
    w: Word;
    hash1Table : array[0..M] of integer;
    hash2Table : array[0..M] of integer;
    hash3Table : array[0..M] of integer;

BEGIN (*WordCounter*)
    OpenFile('Kafka.txt', toLower);
    ReadWord(w);
  WHILE w <> '' DO BEGIN
      ReadWord(w);
      (* Create 3 hashes *)
      inc(hash1Table[stringHash1(w)mod M]);
      inc(hash2Table[stringHash2(w)mod M]);
      inc(hash3Table[stringHash3(w)mod M]);
  END; (*WHILE*)
  (*INSERT GRAPHICAL REPRESENTATION HERE *)
  

END. (*WordCounter*)
