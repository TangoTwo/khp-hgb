unit ModHashTableLinearProbing;
(*$R-*)
interface
function addOrInc(w : string) : integer;
function find(w : string) : integer;
procedure writeTable;
procedure init; 

implementation
uses ModStringHash;

type
    keyValuePair = record
                       key : string;
                       value : integer;
                   end;
    keyValuePairArray = array[0..0] of keyValuePair;
    
var
    tablePtr : ^keyValuePairArray;
    m : integer;

procedure init;
var i : integer;
begin
    m := 3;
    getMem(tablePtr, m * (SIZEOF(keyValuePair)));
    for i := 0 to m-1 do begin
        tablePtr^[i].key := '';
        tablePtr^[i].value := 0;
    end;
end;

procedure writeTable;
var i : integer;
begin
    for i := 0 to m-1 do begin
        writeLn(i, ': ', tablePtr^[i].key, ', ', tablePtr^[i].value);
    end;
end;

function find(w : string) : integer;
var h : integer;
    col : integer;
begin
    h := stringHash1(w) mod m;
    col := 0;
    while(tablePtr^[h].key <> w) and 
            (tablePtr^[h].key <> '') and
            (col < M) do begin
        h:= (h + 1) mod m; (* Instead of 1 multiply by 2 every while run --> quadratic*)
        Inc(col);
    end;
    if tablePtr^[h].key = w then
        find := tablePtr^[h].value
    else
        find := 0;
end;

procedure reallocTable;
var oldTablePtr : ^keyValuePairArray;
    oldM : integer;
    kvp : keyValuePair;
    i, j : integer;
begin
    oldTablePtr := tablePtr;
    oldM := m;
    m := 2 * m;
    getMem(tablePtr, m * SIZEOF(keyValuePair));
    for i := 0 to m-1 do begin
        tablePtr^[i].key := '';
        tablePtr^[i].value := 0;
    end;
    FOR i := 0 to oldM do begin
        kvp := oldTablePtr^[i];
        if kvp.key <> '' then begin
            for j := 1 to kvp.value do begin
                addOrInc(kvp.key);
            end;
        end;
    end;
    freeMem(oldTablePtr, oldM * SIZEOF(keyValuePair));
end;

function addOrInc(w : string) : integer;
var h : integer;
    col : integer;
begin
    h := stringHash1(w) mod m;
    col := 0;
    while(tablePtr^[h].key <> w) and 
            (tablePtr^[h].key <> '') and
            (col < M) do begin
        h:= (h + 1) mod m;
        inc(col);
    end;
    if tablePtr^[h].key = w then
        inc(tablePtr^[h].value)
    else if tablePtr^[h].key = '' then begin
        tablePtr^[h].key := w;
        tablePtr^[h].value := 1;
        addOrInc := tablePtr^[h].value;
    end else begin
        reallocTable;
        addOrInc := addOrInc(w);
    end;
end;

begin
end.
(*$R+*)
