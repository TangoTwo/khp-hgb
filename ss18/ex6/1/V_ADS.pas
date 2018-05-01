unit V_ADS;

interface
procedure errorIfOutOfRange(pos : integer);
procedure add(val : integer);
procedure getElementAt(pos : integer; var val : integer);
procedure setElementAt(pos : integer; val : integer);
procedure removeElementAt(pos : integer);
function size : integer;
function capacity : integer;
function isEmpty : boolean;
procedure init;
procedure disposeStack;
procedure reallocStack;

implementation
type 
    intArray = array [1..1] of integer;

VAR
    arrPtr : ^intArray;
    capacityCount : integer;
    top : integer; (* index of top element *)

procedure init;
begin
    if(arrPtr <> NIL) then begin
        writeln('Can''t initialize non-empty stack!');
        halt;
    end;
    top := 0;
    capacityCount := 2;
    GetMem(arrPtr, SIZEOF(integer) * capacityCount);
end;

procedure errorIfOutOfRange(pos : integer);
begin
    if pos > top then begin
        writeln('Pos out of range!');
        halt;
    end;
end;
procedure add(val : integer);
begin
    if top >= capacityCount then
        reallocStack;
    inc(top);
    (*$R-*)
    arrPtr^[top] := val;
    (*$R+*)
end;

procedure getElementAt(pos : integer; var val : integer);
begin
    errorIfOutOfRange(pos);
    (*$R-*)
    val := arrPtr^[pos];
    (*$R+*)
end;

procedure setElementAt(pos : integer; val : integer);
begin
    errorIfOutOfRange(pos);
    (*$R-*)
    arrPtr^[pos] := val;
    (*$R+*)
end;

procedure removeElementAt(pos : integer);
var
    element : integer;
begin
    errorIfOutOfRange(pos);
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

function size : integer;
begin
    size := top;
end;

function capacity : integer;
begin
    capacity := capacityCount;
end;

function isEmpty : boolean;
begin
    isEmpty := top = 0;
end;

procedure disposeStack;
begin
    if arrPtr = NIL then begin
        writeln('Can''t dispose a uninitialized stack!');
        halt;
    end;
    freeMem(arrPtr, SIZEOF(integer) * capacityCount);
    arrPtr := NIL;
end;

procedure reallocStack;
var
    newArray : ^intArray;
    i : integer;
begin
    getMem(newArray, SIZEOF(INTEGER) * 2 * capacityCount);
    for i := 1 to top do begin
        (*$R-*)
        newArray^[i] := arrPtr^[i];
        (*$R+*)
    end;
    freeMem(arrPtr, SIZEOF(integer) * capacityCount);
    capacityCount := 2 * capacityCount;
    arrPtr := newArray;
end;

begin
    arrPtr := NIL;
end.
