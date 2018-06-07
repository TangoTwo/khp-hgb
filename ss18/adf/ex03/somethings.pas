Program TestPM;

uses ModPatternMatching;
    
type
    PMProc = function(s, p : string) : integer;
    
procedure Test(pos : PMProc);
begin
    writeLn('Expected 25, actual: ', 
            pos('aaaaaaaaaaaaaaaaaaaaaaaaaaab', 'aaab'));
    WriteAndResetStats;
    writeLn('Expected 0, actual: ', 
            pos('xxxxxxxxxxxxxb', 'aaab'));
    WriteAndResetStats;
    writeLn('Expected 31, actual: ', 
            pos('jdfsbjnjnwrbmaüqlwemymnetgfdskjgb', 'kjgb'));
    WriteAndResetStats;
end;

begin
    writeLn('BruteForcePos');
    writeLn('-------------');
    Test(BruteForcePos);
    writeLn('BruteForcePos2');
    writeLn('--------------');
    Test(BruteForcePos2);
    writeLn('KnuthMorrisPratt');
    writeLn('--------------');
    Test(KnuthMorrisPratt);
end.
