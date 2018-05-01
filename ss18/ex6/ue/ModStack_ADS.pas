unit ModStack_ADS;

interface
procedure push(e : integer);
function pop : integer;
function isEmpty : boolean;
procedure init;
procedure disposeStack;

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

procedure push(e : integer);
begin
    if top > capacity then begin
        writeln('Stackoverflow!');
        halt;
    end;
    inc(top);
    (*$R-*)
    arrPtr^[top] := e;
    (*$R+*)
end;

function pop : integer;
begin
    if isEmpty then begin
        writeln('Stack is empty');
        halt;
    end;
    dec(top);
    (*$R-*)
    pop := arrPtr^[top+1];
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

begin
    arrPtr := NIL;
end.
