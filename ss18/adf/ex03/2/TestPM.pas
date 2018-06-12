PROGRAM TestPM;

USES ModPatternMatching;

TYPE
  PMProc = FUNCTION(s, p : STRING): INTEGER;

PROCEDURE Test(pos: PMProc);
BEGIN
  WriteLn('Excpected 22, actual:',
        pos('aaaaaaaaaaaaaaaaaaaaaaaab', 'aaab'));
  WriteAndResetStats;
  WriteLn('Excpected 0, actual:',
        pos('XXXXXXXXXXXXXXXXXXXXXXXXb', 'aaab'));
  WriteAndResetStats;
  WriteLn('Excpected 22, actual:',
        pos('aAasdfjoasvjoawerbafoassb', 'assb'));
  WriteAndResetStats;
END;

BEGIN
  WriteLn('BruteForcePos');
  WriteLn('-------------');
  Test(BruteForcePos);
  
  WriteLn('BruteForcePos2 ');
  WriteLn('-------------');
  Test(BruteForcePos2);  
END.