unit MLInt;

interface
uses MLObj;
type
    MLInteger = ^MLIntegerObj;
    MLIntegerObj = object(MLObjectObj)
        constructor init(val : integer);
        (* destructor done; virtual; *)
        function asString : string; virtual;
        function isEqualTo(o : MLObject) : boolean; virtual;
        function isLessThan(o : MLObject) : boolean; virtual;
        private
        val : integer;
        end;
function newInteger(val : integer) : MLInteger;
implementation

function newInteger(val : integer) : MLInteger;
var i : MLInteger;
begin
    new(i, init(val));
    newInteger := i;
end;

constructor MLIntegerObj.init(val : integer);
begin
    inherited init;
    register('MLInteger', 'MLObject');
    self.val := val;
end;

function MLIntegerObj.asString : string;
var s : string;
begin
    str(val, s);
    asString := s;
end;

function MLIntegerObj.isEqualTo(o : MLObject) : boolean;
var other : MLInteger;
begin
    if o^.Class = 'MLInteger' then begin
        other := MLInteger(o);
        isEqualTo := SELF.val = other^.val;
    end else
        isEqualTo := FALSE;
end;

function MLIntegerObj.isLessThan(o : MLObject) : boolean;
var other : MLInteger;
begin
    if o^.class = 'MLInteger' then begin
        other := MLInteger(o);
        isLessThan := self.val < other^.val;
    end else
        isLessThan := FALSE;
end;

begin
end.
