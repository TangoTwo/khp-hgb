unit V_AV;

const INIT_CAP_SIZE = 16;

type
    intArray = array[1..1] of integer;
    Vector = ^VectorObj;
    VectorObj = OBJECT
        PRIVATE
            arrPtr : ^intArray;
            capacityCount : integer;
            top : integer; //equals size
            PUBLIC
                constructor init;
                procedure add(val : integer);
                procedure instertElementAt(pos : integer; val : integer);
                procedure getElementAt(pos : integer; var val : integer; var ok : boolean);
                function size : integer;
                function capacity : integer;
                procedure clear;
            PRIVATE
                procedure realloc;
                procedure errorIfOutOfRange(pos : integer);
    end;

constructor init;
begin
    if(arrPtr <> NIL) then begin
        writeln('Can''t initialize non-empty stack!');
        halt;
    end;
    new(arrPtr);
    top := 0;
    capacityCount := INIT_CAP_SIZE;
    GetMem(arrPtr, SIZEOF(integer) * capacityCount);
end;

procedure add(val : integer);
begin
    if top >= capacityCount then begin
        realloc;
    end;
    inc(top);
    (*$R-*)
    arrPtr^[top] := val;
    (*$R+*)
end;

procedure insertElementAt(pos : integer; val : integer);
begin
    errorIfOutOfRange(isPtr, pos);
    inc(top);
    for pos+1 to top do
        arrPtr^[pos] := arrPtr^[pos-1];
    (*$R-*)
    isPtr^.arrPtr^[pos] := val;
    (*$R+*)
end;

procedure getElementAt(pos : integer; var val : integer; var ok : boolean);
begin
    errorIfOutOfRange(pos);
    (*$R-*)
    val := arrPtr^[pos];
    (*$R+*)
end;

function size : integer;
begin
    size := top;
end;

function capacity : integer;
begin
    capacity := capacityCount;
end;

procedure clear;
begin
    if arrPtr = NIL then begin
        writeLn('Cannot dispose uninitialized vector!');
        halt;
    end;
    freeMem(arrPtr, SIZEOF(integer) * capacityCount);
    arrPtr := NIL;
    init;
end;

procedure realloc;
var newArray : ^intArray;
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

procedure errorIfOutOfRange(pos : integer);
begin
    if pos > top then begin
        writeln('Pos out of range!');
        halt;
    end;
end;

begin
end.
