unit ModHashTableChaining;

interface
function addOrInc(w : string) : integer;
function find(w : string) : integer;
procedure writeTable;
procedure init; 

implementation
uses ModStringHash;
const
    M = 53;
type
    NodePtr = ^NodeRec;
    NodeRec = record
                  key : string;
                  val : integer;
                  next : NodePtr;
              end;
    ListPtr = NodePtr;
    
var
    table : array[0..M-1] of ListPtr;
    
function addOrInc(w : string) : integer;
var h : integer;
    n : NodePtr;
begin
    h := stringHash1(w) mod M;
    n := table[h];
    while (n <> NIL) and (n^.key <> w) do 
        n := n^.next;
    if n = NIL then begin
        New(n);
        n^.key := w;
        n^.val := 1;
        n^.next := table[h];
        table[h] := n;
    end else 
        inc(n^.val);
    addOrInc := n^.val;
end;

function find(w : string) : integer;
var h : integer;
    n : NodePtr;
begin
    h := stringHash1(w) mod M;
    n := table[h];
    while (n <> NIL) and (n^.key <> w) do 
        n := n^.next;
    if n = NIL then
        find := 0
    else
        find := n^.val;
end;

procedure init; 
var
    i : integer;
begin
    (* TODO: if entries exist we need to dispose them*)
    for i := 0 to M-1 do begin
        table[i] := NIL;
    end;
end;

procedure writeList(n : ListPtr);
Begin
    if n = NIL then
        Write(' -| ')
    else begin
        write('-> ', n^.key, ',', n^.val);
        writeList(n^.next);
    end;
end;
    

procedure writeTable;
var i : integer;
begin
    for i := 1 to M -1 do begin
        WriteList(table[i]);
        WriteLn;
    end;
end;


begin
end.
