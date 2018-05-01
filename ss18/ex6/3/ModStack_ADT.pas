unit ModStack_ADT;

interface
type
    intArray = array [1..1] of integer;
    stack = POINTER;
                
procedure push(var s : stack; e : integer);
procedure pop(var s : stack; var e : integer);
function isEmpty(s: stack) : boolean;
procedure init(var s : stack);
procedure disposeStack(var s : stack);

implementation
type
    intStackPtr = ^intStack;
    intStack = record
                arrPtr : ^intArray;
                capacity : integer;
                top : integer; (* index of top element *)
            end;
procedure reallocStack(var s : stack); FORWARD;

procedure init(var s : stack);
var cs : intStackPtr;
begin
    cs := IntStackPtr(s);
    if(cs.arrPtr <> NIL) then begin
        writeln('Call disposeStack first you maniac!');
        halt;
    end;
    cs.top := 0;
    cs.capacity := 10;
    GetMem(cs.arrPtr, SIZEOF(integer) * cs.capacity);
end;

procedure push(var s : stack; e : integer);
begin
    if s.top > s.capacity then begin
        reallocStack(s);
    end;
    inc(s.top);
    (*$R-*)
    s.arrPtr^[s.top] := e;
    (*$R+*)
end;

procedure pop(var s : stack; var e : integer);
begin
    if isEmpty(s) then begin
        writeln('Stack is empty');
        halt;
    end;
    dec(s.top);
    (*$R-*)
    e := s.arrPtr^[s.top+1];
    (*$R+*)
end;

function isEmpty(s : stack) : boolean;
begin
    isEmpty := s.top = 0;
end;

procedure disposeStack(var s : stack);
begin
    if s.arrPtr = NIL then begin
        writeln('Stack is not initialized you moron!');
        halt;
    end;
    FreeMem(s.arrPtr, SIZEOF(integer) * s.capacity);
    s.arrPtr := NIL;
end;

procedure reallocStack(var s : stack);
var newArray : ^intArray;
    i : integer;
begin
    GetMem(newArray, SIZEOF(INTEGER) * 2 * s.capacity);
    for i := 1 to s.top do begin
        (*$R-*)
        newArray^[i] := s.arrPtr^[i];
        (*$R+*)
    end;
    FreeMem(s.arrPtr, SIZEOF(integer) * s.capacity);
    s.capacity := 2 * s.capacity;
    s.arrPtr := newArray;
end;

begin
end.
