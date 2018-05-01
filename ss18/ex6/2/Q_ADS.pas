unit Q_ADS;

interface
procedure enqueue(e : integer);
function dequeue : integer;
function isEmpty : boolean;
procedure init;
procedure disposeStack;
procedure reallocStack;

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
        writeln('Call disposeStack first you maniac!');
        halt;
    end;
    top := 0;
    capacity := 10;
    GetMem(arrPtr, SIZEOF(integer) * capacity);
end;

procedure enqueue(e : integer);
begin
    if top >= capacity then
        reallocStack;
    inc(top);
    (*$R-*)
    arrPtr^[top] := e;
    (*$R+*)
end;

function dequeue : integer;
begin
    if isEmpty then begin
        writeln('Stack is empty');
        halt;
    end;
    dec(top);
    (*$R-*)
    dequeue := arrPtr^[top+1];
    (*$R+*)
end;

function isEmpty : boolean;
begin
    isEmpty := top = 0;
end;

procedure disposeStack;
begin
    if arrPtr = NIL then begin
        writeln('Stack is not initialized you moron!');
        halt;
    end;
    FreeMem(arrPtr, SIZEOF(integer) * capacity);
    arrPtr := NIL;
end;

procedure reallocStack;
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

begin
    arrPtr := NIL;
end.
