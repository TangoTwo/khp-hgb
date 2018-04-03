unit ModBinarySearchTree;

interface
function addOrInc(w : string) : integer;
function find(w : string) : integer;
procedure init; 
    
implementation
uses ModStringHash;
const
    M = 53;
    LEFT = 1;
    RIGHT = 2;
type
    NodePtr = ^NodeRec;
    NodeRec = record
                  key : string;
                  hash : integer;
                  val : integer;
                  left : NodePtr;
                  right : NodePtr;
              end;
    
var
    root : NodePtr;
    
function addOrInc(w : string) : integer;
var
    h : integer;
    n : NodePtr;
    nOld : NodePtr;
    direction : integer;
begin
    h := stringHash1(w) mod M;
    n := root;
    nOld := n;
    direction := 0; //1 == LEFT, 2 == RIGHT
    while (n <> NIL) and (n^.key <> w) do 
    begin
        nOld := n;
        if h < n^.hash then begin
            n := n^.left;
            direction := LEFT;
        end else begin
            n := n^.right;
            direction := RIGHT;
        end;
    end;
    if n = NIL then begin
        New(n);
        n^.key := w;
        n^.hash := h;
        n^.val := 1;
        n^.left := NIL;
        n^.right := NIL;
        if direction = LEFT then
            nOld^.left := n
        else if direction = RIGHT then
            nOld^.right := n
        else 
            root := n;
    end else 
        inc(n^.val);
    addOrInc := n^.val;
end;

function find(w : string) : integer;
var h : integer;
    n : NodePtr;
begin
    h := stringHash1(w) mod M;
    n := root;
    while (n <> NIL) and (n^.key <> w) do begin
        if h < n^.hash then
            n := n^.left
        else
            n := n^.right;
    end;
    if n = NIL then
        find := 0
    else
        find := n^.val;
    
end;

procedure init; 
begin
    root := NIL;
end;


begin
end.
