UNIT BinTree;

interface

type
    NodePtr = ^Node;
    Node = record
               left, right: nodePtr;
               val: string;
           end;
    TreePtr = NodePtr;

function newTree(val: string): NodePtr;
procedure disposeTree(var t: TreePtr);
procedure writeTreeInOrder(t: TreePtr);
//function valueOf(n: NodePtr): integer;

implementation

function newTree(val: string): NodePtr;
var
    n: NodePtr;
begin
    New(n);
    n^.left := NIL;
    n^.right := NIL;
    n^.val := val;
    newTree := n;
end;

procedure disposeTree(var t: TreePtr);
begin
    if (t <> NIL) then begin
        disposeTree(t^.left);
        disposeTree(t^.right);
        dispose(t);
        t := NIL;
    end;
end;

function height(t: TreePtr): integer;
function max(a, b: integer): integer;
begin
    if(a > b) then max := a
    else max := b
end;
begin
    if(t = NIL) then height := 0
    else height := 1 + max(height(t^.left), height(t^.right))
end;

procedure writeTreeInOrder(t: TreePtr);
var
    maxHeight: integer;
procedure writeTree(n: NodePtr);
begin
    if(n <> NIL) then begin
        writeTree(n^.left);
        writeLn('':(maxHeight - height(n)),n^.val);
        writeTree(n^.right);
    end;
end;
begin
    maxHeight := height(t);
    writeln;
    writeTree(t);
    writeln;
end;

begin
end.
