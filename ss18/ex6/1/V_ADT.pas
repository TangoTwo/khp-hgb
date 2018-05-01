unit V_ADT;

interface
type
    intArray = array [1..1] of integer;
    stackPtr = POINTER;
    
procedure add(s : stackPtr; val : integer);
procedure getElementAt(s : stackPtr; pos : integer; var val : integer);
procedure setElementAt(s : stackPtr; pos : integer; val : integer);
procedure removeElementAt(s : stackPtr; pos : integer);
function size(s : stackPtr) : integer;
function capacity(s : stackPtr) : integer;
function isEmpty(s : stackPtr) : boolean;
procedure init(var s : stackPtr);
procedure disposeStack(var s : stackPtr);

implementation
type
    internalStackPtr = ^stack;
    stack = record
                arrPtr : ^intArray;
                capacityCount : integer;
                top : integer; (* index of top element *)
            end;
procedure reallocStack(var s : stackPtr); FORWARD;
procedure errorIfOutOfRange(s : stackPtr; pos : integer); FORWARD;

procedure init(var s : stackPtr);
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    if(s <> NIL) then begin
        writeln('Can''t initialize non-empty stack!');
        halt;
    end;
    new(isPtr);
    isPtr^.top := 0;
    isPtr^.capacityCount := 16;
    GetMem(isPtr^.arrPtr, SIZEOF(integer) * isPtr^.capacityCount);
    s := isPtr;
end;

procedure errorIfOutOfRange(s : stackPtr; pos : integer);
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    if pos > isPtr^.top then begin
        writeln('Pos out of range!');
        halt;
    end;
end;

procedure add(s : stackPtr; val : integer);
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    if isPtr^.top >= isPtr^.capacityCount then begin
        reallocStack(s);
    end;
    inc(isPtr^.top);
    (*$R-*)
    isPtr^.arrPtr^[isPtr^.top] := val;
    (*$R+*)
end;

procedure getElementAt(s : stackPtr; pos : integer; var val : integer);
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    errorIfOutOfRange(isPtr, pos);
    (*$R-*)
    val := isPtr^.arrPtr^[pos];
    (*$R+*)
end;

procedure setElementAt(s : stackPtr; pos : integer; val : integer);
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    errorIfOutOfRange(isPtr, pos);
    (*$R-*)
    isPtr^.arrPtr^[pos] := val;
    (*$R+*)
end;

procedure removeElementAt(s : stackPtr; pos : integer);
var
    isPtr : internalStackPtr;
    element : integer;
begin
    isPtr := internalStackPtr(s);
    errorIfOutOfRange(isPtr, pos);
    element := pos + 1;
    while element <= isPtr^.top do begin
        (*$R-*)
        isPtr^.arrPtr^[element - 1] := isPtr^.arrPtr^[element];
        (*$R+*)
        inc(element);
    end;
    (*$R-*)
    isPtr^.arrPtr^[isPtr^.top] := 0;
    (*$R+*)
    dec(isPtr^.top);
end;

function size(s : stackPtr) : integer;
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    size := isPtr^.top;
end;

function capacity(s : stackPtr) : integer;
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    capacity := isPtr^.capacityCount;
end;

function isEmpty(s : stackPtr) : boolean;
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    isEmpty := isPtr^.top = 0;
end;

procedure disposeStack(var s : stackPtr);
var isPtr : internalStackPtr;
begin
    if s = NIL then begin
        writeln('Can''t dispose a uninitialized stack!');
        halt;
    end;
    isPtr := internalStackPtr(s);
    freeMem(isPtr^.arrPtr, SIZEOF(integer) * isPtr^.capacityCount);
    isPtr^.arrPtr := NIL;
    dispose(isPtr);
    s := NIL;
end;

procedure reallocStack(var s : stackPtr);
var isPtr : internalStackPtr;
    newArray : ^intArray;
    i : integer;
begin
    isPtr := internalStackPtr(s);
    getMem(newArray, SIZEOF(INTEGER) * 2 * isPtr^.capacityCount);
    for i := 1 to isPtr^.top do begin
        (*$R-*)
        newArray^[i] := isPtr^.arrPtr^[i];
        (*$R+*)
    end;
    freeMem(isPtr^.arrPtr, SIZEOF(integer) * isPtr^.capacityCount);
    isPtr^.capacityCount := 2 * isPtr^.capacityCount;
    isPtr^.arrPtr := newArray;
end;

begin
end.
