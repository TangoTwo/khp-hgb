program V_AV;

const DEFAULT_CAP_SIZE = 16;

type
    intArray = array[1..1] of integer;
    Vector = ^VectorObj;
    VectorObj = OBJECT
        PRIVATE
            arrPtr : ^intArray;
            capacityCount : integer;
            top : integer; //equals size
            initCapacity : integer;
            PUBLIC
                constructor init(userCapacity : integer);
                destructor done;
                procedure add(val : integer); virtual;
                procedure insertElementAt(pos : integer; val : integer); virtual;
                procedure getElementAt(pos : integer; var val : integer; var ok : boolean);
                function size : integer;
                function capacity : integer;
                procedure clear;
            PRIVATE
                procedure realloc;
                function isOutOfRange(pos : integer) : boolean;
    end;
    NaturalVector = ^NaturalVectorObj;
    NaturalVectorObj = OBJECT(VectorObj)
        PUBLIC
            procedure add(val : integer); virtual;
            procedure insertElementAt(pos : integer; val : integer); virtual;
        PRIVATE
            function isNatural(val : integer) : boolean;
    end;
    PrimeVector = ^PrimeVectorObj;
    PrimeVectorObj = OBJECT(VectorObj)
        PUBLIC
            procedure add(val : integer); virtual;
            procedure insertElementAt(pos : integer; val : integer); virtual;
        PRIVATE
            function isPrime(val : integer) : boolean;
    end;
            

constructor VectorObj.init(userCapacity : integer);
begin
    if(arrPtr <> NIL) then begin
        writeln('Can''t initialize non-empty stack!');
        halt;
    end;
    if(userCapacity <= 0) then begin
        writeLn('No capacity given. Creating with default size ', DEFAULT_CAP_SIZE);
        initCapacity := DEFAULT_CAP_SIZE;
    end else
        initCapacity := userCapacity;
    new(arrPtr);
    top := 0;
    capacityCount := initCapacity;
    GetMem(arrPtr, SIZEOF(integer) * capacityCount);
end;

destructor VectorObj.done;
begin
    freeMem(arrPtr, SIZEOF(integer) * capacityCount);
    arrPtr := NIL;
end;

procedure VectorObj.add(val : integer);
begin
    if top >= capacityCount then begin
        realloc;
    end;
    inc(top);
    (*$R-*)
    arrPtr^[top] := val;
    (*$R+*)
end;

procedure VectorObj.insertElementAt(pos : integer; val : integer);
var i : integer;
begin
    inc(top);
    if(isOutOfRange(pos)) then
        pos := top
    else if pos < 0 then
        pos := 0;
    i := top;
    while (i > pos) do begin
        (*$R-*)
        arrPtr^[i] := arrPtr^[i-1];
        (*$R+*)
        dec(i);
    end;
    (*$R-*)
    arrPtr^[pos] := val;
    (*$R+*)
end;

procedure VectorObj.getElementAt(pos : integer; var val : integer; var ok : boolean);
begin
    ok := TRUE;
    if(isOutOfRange(pos)) then begin
        ok := FALSE;
        val := -1;
        exit;
    end;
    (*$R-*)
    val := arrPtr^[pos];
    (*$R+*)
end;

function VectorObj.size : integer;
begin
    size := top;
end;

function VectorObj.capacity : integer;
begin
    capacity := capacityCount;
end;

procedure VectorObj.clear;
begin
    if arrPtr = NIL then begin
        writeLn('Cannot dispose uninitialized vector!');
        halt;
    end;
    freeMem(arrPtr, SIZEOF(integer) * capacityCount);
    arrPtr := NIL;
    init(initCapacity);
end;

procedure VectorObj.realloc;
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

function VectorObj.isOutOfRange(pos : integer) : boolean;
begin
    if pos > top then
        isOutOfRange := TRUE
    else
        isOutOfRange := FALSE
end;

procedure NaturalVectorObj.add(val : integer);
begin
    if NOT isNatural(val) then begin
        writeln('Given value is not a natural number!');
        exit;
    end;
    inherited add(val);
end;

procedure NaturalVectorObj.insertElementAt(pos : integer; val : integer);
begin
    if NOT isNatural(val) then begin
        writeln('Given value is not a natural number!');
        exit;
    end;
    inherited insertElementAt(pos, val);
end;

function NaturalVectorObj.isNatural(val : integer) : boolean;
begin
    if(val >= 0) then
        isNatural := TRUE
    else
        isNatural := FALSE;
end;

procedure PrimeVectorObj.add(val : integer);
begin
    if NOT isPrime(val) then begin
        writeln('Given value is not a prime number!');
        exit;
    end;
    inherited add(val);
end;

procedure PrimeVectorObj.insertElementAt(pos : integer; val : integer);
begin
    if NOT isPrime(val) then begin
        writeln('Given value is not a prime number!');
        exit;
    end;
    inherited insertElementAt(pos, val);
end;

function PrimeVectorObj.isPrime(val : integer) : boolean;
var i : integer;
begin
    isPrime := TRUE;
    if(val <= 1) then begin
        isPrime := FALSE;
        exit;
    end;
    for i := 2 to val div 2-1 do
        if val mod i = 0 then
            isPrime := FALSE;
end;

var
    intVector : vector;
    natVector : NaturalVector;
    priVector : PrimeVector;
    i : integer;
    tVal : integer;
    ok : boolean;
begin
    New(intVector, init(4));
    New(natVector, init(20));
    New(priVector, init(17));
    
    for i := -20 to 20 do begin
        intVector^.add(i);
        natVector^.add(i);
        priVector^.add(i);
    end;
    writeLn('Current size intVec: ', intVector^.size);
    writeLn('Current size natVector: ', natVector^.size);
    writeLn('Current size priVector: ', priVector^.size);

    write('intVec=[');
    for i := 1 to intVector^.capacity do begin
        intVector^.getElementAt(i, tVal, ok);
        if(ok) then
            write(tVal,',')
    end;
    write(']');
    writeln;

    write('natVec=[');
    for i := 1 to natVector^.capacity do begin
        natVector^.getElementAt(i, tVal, ok);
        if(ok) then
            write(tVal,',')
    end;
    write(']');
    writeln;

    write('priVec=[');
    for i := 1 to priVector^.capacity do begin
        priVector^.getElementAt(i, tVal, ok);
        if(ok) then
            write(tVal,',')
    end;
    write(']');
    writeln;
end.
