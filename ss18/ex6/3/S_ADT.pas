unit S_ADT;

interface
type
    intArray = array [1..1] of integer;
    stackPtr = POINTER;
                
procedure push(s : stackPtr; e : integer);
procedure pop(s : stackPtr; var e : integer);
function isEmpty(s: stackPtr) : boolean;
procedure init(var s : stackPtr);
procedure disposeStack(var s : stackPtr);

implementation
type
    internalStackPtr = ^stack;
    stack = record
                arrPtr : ^intArray;
                capacity : integer;
                top : integer; (* index of top element *)
            end;
procedure reallocStack(s : stackPtr); FORWARD;

procedure init(var s : stackPtr);
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    
    if s <> NIL then begin
        writeln('Call disposeStack first you maniac!');
        halt;
    end;
    new(isPtr);
    isPtr^.top := 0;
    isPtr^.capacity := 10;
    GetMem(isPtr^.arrPtr, SIZEOF(integer) * isPtr^.capacity);
    s := isPtr;
end;

procedure push(s : stackPtr; e : integer);
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    if isPtr^.top >= isPtr^.capacity then begin
        reallocStack(s);
    end;
    inc(isPtr^.top);
    (*$R-*)
    isPtr^.arrPtr^[isPtr^.top] := e;
    (*$R+*)
end;

procedure pop(s : stackPtr; var e : integer);
var isPtr : internalStackPtr;
begin
    isPtr := internalStackPtr(s);
    if isEmpty(s) then begin
        writeln('Stack is empty');
        halt;
    end;
    dec(isPtr^.top);
    (*$R-*)
    e := isPtr^.arrPtr^[isPtr^.top+1];
    (*$R+*)
end;

function isEmpty(s : stackPtr) : boolean;
begin
    isEmpty := internalStackPtr(s)^.top = 0;
end;

procedure disposeStack(var s : stackPtr);
var isPtr : internalStackPtr;
begin
    if s = NIL then begin
        writeln('Stack is not initialized you moron!');
        halt;
    end;
    isPtr := internalStackPtr(s);
    FreeMem(isPtr^.arrPtr, SIZEOF(integer) * isPtr^.capacity);
    isPtr^.arrPtr := NIL;
    dispose(isPtr);
    s := NIL;
end;

procedure reallocStack(s : stackPtr);
var isPtr : internalStackPtr;
    newArray : ^intArray;
    i : integer;
begin
    isPtr := internalStackPtr(s);
    GetMem(newArray, SIZEOF(INTEGER) * 2 * isPtr^.capacity);
    for i := 1 to isPtr^.top do begin
        (*$R-*)
        newArray^[i] := isPtr^.arrPtr^[i];
        (*$R+*)
    end;
    FreeMem(isPtr^.arrPtr, SIZEOF(integer) * isPtr^.capacity);
    isPtr^.capacity := 2 * isPtr^.capacity;
    isPtr^.arrPtr := newArray;
end;

begin
end.
