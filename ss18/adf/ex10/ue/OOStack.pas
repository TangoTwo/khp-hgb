program OOStack;

const
	MAX = 100;
	
type

	IntArray = array [1..MAX] of integer;
	Stack = ^StackObj;
	StackObj = object
				private
					arr: ^IntArray;
					top: integer;
					cap: integer;
				public
					CONSTRUCTOR init(initCap : integer);
					DESTRUCTOR done; virtual;
					procedure push(e: integer); virtual;
					function pop : integer; virtual;
					function isEmpty : boolean; virtual;
				end; (*Stack*)
DynArrStack = ^DynArrStackObj;
DynArrStackObj = object(StackObj)
						constructor init(initCap : integer);
						procedure push(e : integer); virtual;
						function pop : integer; virtual;
					private
						procedure realloc;
				end;

constructor StackObj.init(initCap : integer);
begin
	if (initCap <= 0) or (initCap > MAX) then begin
		writeLn('Invalid capacity in constructor of stack!');
		halt;
	end;
	top := 0;
	cap := initCap;
	getMem(arr, SIZEOF(integer) * cap);
end;

destructor StackObj.done;
begin
	(* free all mememory! For Scotland *)
	freeMem(arr, sizeof(integer) * cap);
end;

procedure StackObj.Push(e: integer);
begin
	if top < cap then begin
		inc(top);
		arr^[top] := e;
	end else begin
		writeLn('Stack is full');
		halt;
	end;
end;

function StackObj.pop: integer;
begin
	if isEmpty then begin
		writeLn('Stack is empty');
		halt;
	end;
	pop := arr^[top];
	dec(top);
end;

function StackObj.isEmpty: boolean;
begin
	isEmpty := top = 0;
end;

(*****************************)
(********** DynArrStack ******)
(*****************************)
constructor DynArrStackObj.init(initCap: integer);
begin
	inherited init(initCap);
	cap := initCap;
end;

procedure DynArrStackObj.push(e: integer);
begin
	if top = cap then begin
		realloc;
	end;
	inc(top);
	(*$R-*) arr^[top] := e; (*R+*)
end;

function DynArrStackObj.pop : integer;
begin
	if isEmpty then begin
		writeLn('Stack is empty');
		halt;
	end;
	(*R-*)pop := arr^[top];(*R+*)
	dec(top);
end;

procedure DynArrStackObj.realloc;
var newArr : ^IntArray;
	i : integer;
begin
	getMem(newArr, 2 * cap * SIZEOF(integer));
	for i := 1 to top do begin
		(*R-*) newArr^[i] := arr^[i];(*R+*)
	end;
	freeMem(arr, cap * SIZEOF(integer));
	arr := newArr;
	cap := 2*cap;
end;

var s: Stack;
	dynS : DynArrStack;
	i: integer;

begin
	New(dynS, Init(10));
	s := dyns;
	for i := 1 to 12 do begin
		s^.push(i);
	end;
	writeLn('IsEmpty:', s^.isEmpty);
	while not s^.isEmpty do begin
		writeLn(s^.pop);
	end;
	Dispose(s, Done);
end.