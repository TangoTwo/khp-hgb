unit Q_ADS;

interface
procedure enqueue(e : integer);
function dequeue : integer;
function isEmpty : boolean;
procedure init;
procedure disposeQueue;
procedure reallocQueue;
procedure removeElementAt(pos : integer);

implementation
type 
    intArray = array [1..1] of integer;

VAR
    arrPtr : ^intArray;
    capacity : integer;
    top : integer; (* index of top element *)

procedure init;
begin
    if(arrPtr <> NIL) then begin
        writeln('Can''t initialize non-empty queue!');
        halt;
    end;
    top := 0;
    capacity := 10;
    GetMem(arrPtr, SIZEOF(integer) * capacity);
end;

procedure enqueue(e : integer);
begin
    if top >= capacity then
        reallocQueue;
    inc(top);
    (*$R-*)
    arrPtr^[top] := e;
    (*$R+*)
end;

function dequeue : integer;
begin
    if isEmpty then begin
        writeln('Queue is empty');
        halt;
    end;
    (*$R-*)
    dequeue := arrPtr^[1];
    (*$R+*)
    removeElementAt(1);
end;

function isEmpty : boolean;
begin
    isEmpty := top = 0;
end;

procedure disposeQueue;
begin
    if arrPtr = NIL then begin
        writeln('Can''t dispose a uninitialized queue!');
        halt;
    end;
    FreeMem(arrPtr, SIZEOF(integer) * capacity);
    arrPtr := NIL;
end;

procedure reallocQueue;
var
    newArray : ^intArray;
    i : integer;
begin
    GetMem(newArray, SIZEOF(INTEGER) * 2 * capacity);
    for i := 1 to top do begin
        (*$R-*)
        newArray^[i] := arrPtr^[i];
        (*$R+*)
    end;
    FreeMem(arrPtr, SIZEOF(integer) * capacity);
    capacity := 2 * capacity;
    arrPtr := newArray;
end;

procedure removeElementAt(pos : integer);
var
    element : integer;
begin
    element := pos + 1;
    while element <= top do begin
        (*$R-*)
        arrPtr^[element - 1] := arrPtr^[element];
        (*$R+*)
        inc(element);
    end;
    (*$R-*)
    arrPtr^[top] := 0;
    (*$R+*)
    dec(top);
end;

begin
    arrPtr := NIL;
end.
