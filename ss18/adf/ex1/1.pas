program statistics
uses ModLCGRandom;

interface
procedure ComputeRuns( n : integer;
                       var maxAsc, maxDesc : integer;
                       var asc, desc : intArray);

var h : integer;
    n : integer;

begin
