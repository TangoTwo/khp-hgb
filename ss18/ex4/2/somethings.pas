Program TestPM;

uses ModPatternMatchingUnsharp;
    
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
    writeLn('Expected 25, actual: ', 
            pos('aaaaaaaaaaaaaaaaaaaaaaaabaaa', 'baaa'));
    WriteAndResetStats;
    writeLn('Expected 31, actual: ', 
            pos('kjab', 'kj?b'));
        WriteAndResetStats;
end;

procedure title(name : string);
begin
    writeLn;
    writeLn(name);
    writeLn('-------------');
end;

begin
    title('BruteForcePos');
    Test(BruteForcePos);
    title('BruteForcePos2');
    Test(BruteForcePos2);
    title('BruteForcePos2');
    Test(BruteForcePos2);
    title('KnuthMorrisPratt');
    Test(KnuthMorrisPratt);
    title('BruteForceRL');
    Test(BruteForceRL);
    title('BoyerMoore');
    Test(BoyerMoore);
    title('RabinKarp');
    Test(RabinKarp);
end.
