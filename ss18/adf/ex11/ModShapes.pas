unit modShapes;

interface

uses WinGraph; (* for HDC *)
	const
		MAX = 10;

type
	pointRec = record
				x : integer;
				y : integer;
			end;
	shape = class
                visible : boolean;
                name : string;
				procedure move(mx, my : integer); virtual; abstract; (* abstract methods have no definition *)
				procedure write; virtual; abstract;
				procedure draw(dc : HDC); virtual; abstract;
                function contains(ident : string) : pointer; virtual;
			end;
	shapeArray = array[1..MAX] of shape;
	line = class(shape)
				private
					startP, endP : PointRec;
				public
					constructor init(tStartP, tEndP : pointRec; ident : string);
					procedure move(mx, my : integer); virtual;
                    procedure write; virtual; 
                    procedure draw(dc : HDC); virtual;
			end;

	rectangle = class(shape)
					private
						p0, p1, p2, p3 : pointRec;
					public
						constructor init(lt, rb : pointRec; ident : string);
						procedure move(mx, my : integer); virtual;
                        procedure write; virtual;
                        procedure draw(dc : HDC); virtual;
				end;
	circle = class(shape)
					private
						center : pointRec;
						radius : integer;
					public
						constructor init(c : pointRec;
                                         r : integer;
                                         ident : string
                                        );
						procedure move(mx, my : integer); virtual;
                        procedure write; virtual;
                        procedure draw(dc : HDC); virtual;
				end;

	picture = class(shape)
					private
						shapes : shapeArray;
						numShapes : integer;
					public
						constructor init(ident : string);
						procedure move(mx, my : integer); virtual;
						procedure add(s : shape);
                        procedure write; virtual;
                        procedure draw(dc : HDC); virtual;
                        function contains(ident : string) : pointer; virtual;
				end;

implementation

procedure addToPoint(var p : pointRec; x, y : integer);
begin
	p.x := p.x + x;
	p.y := p.y + y;
end;

(***************Shape**************)
function shape.contains(ident : string) : Pointer;
begin
    if(name = ident) then
        contains := Pointer(self);
    else
        contains := NIL;
end;
(***************Line***************)
constructor line.init(tStartP, tEndP : PointRec; ident : string);
begin
    self.name := ident;
	self.startP := tStartP;
	self.endP := tEndP;
	visible := TRUE;
end;

procedure line.move(mx, my : integer);
begin
	addToPoint(startP, mx, my);
	addToPoint(endP, mx, my);
end;

procedure line.write;
begin
	writeLn('Line from ', startP. x, ',', startP.y, ') to (', endP.x, ',' endP.y, ')');
end;

procedure line.draw(dc : HDC);
begin
    moveTo(dc, startP.x, startP.y);
    lineTo(dc, endP.x, endP.y);
end;

(************************RECTANGLE*****************)
constructor rectangle.init(lt, rb : PointRec; ident : string);
begin
    self.name := ident;
	p0 := lt;
	p2 := rb;
	p1.x := p2.x;
	p1.y := p0.y;
	p3.x := p0.x;
	p3.y := p2.y;
end;

procedure rectangle.move(mx, my : integer);
begin
	addToPoint(p0, mx, my);
	addToPoint(p1, mx, my);
	addToPoint(p2, mx, my);
	addToPoint(p3, mx, my);
end;

procedure rectangle.write;
begin
	writeLn('Rectangle: ');
	writeLn('(', p0.x,',', p0.y,')');
end;

procedure rectangle.draw(dc : HDC);
begin
    moveTo(dc, p0.x, p0.y);
    lineTo(dc, p1.x, p1.y);
    lineTo(dc, p2.x, p2.y);
    lineTo(dc, p3.x, p3.y);
    lineTo(dc, p0.x, p0.y);
end;

(*********************Circle****************************)
constructor circle.init(c: pointRec; r : integer; ident : string);
begin
    self.name := ident;
	self.center := c;
	self.radius := r;
	visible := TRUE;
end;

procedure circle.move(mx, my : integer),
begin
	addToPoint(center, mx, my);
end;

procedure circle.write;
begin
	writeLn('Circle with center: (', center.x, ',', center.y, ') radius: ', radius);
end;

procedure circle.draw(dc : HDC);
begin
    
end;

(********************PICTURE**************************)
constructor picture.init(ident : string);
begin
    self.name := ident;
	numShapes := 0;
	visible := TRUE;
end;

procedure picture.move(mx, my : integer);
var i : integer;
begin
	for i := 1 to numShapes do
		shapes[i].move(mx, my);
end;

procedure picture.add(s : shape);
begin
	if numShapes >= MAX then begin
		writeLn('Picture is full');
		halt;
	end;
	if s = self then begin
		writeLn('Cannot add picture to itself');
		halt;
	end;
	inc(numShapes);
	shapes[numShapes] := s;
end;

procedure picture.write
var i : integer;
begin
	writeLn('Picture with ', numShapes, ' shapes: ');
	for i := 1 to numShapes do
		shapes[i].write;
end;

procedure picture.draw(dc : HDC);
var i : integer;
begin
    for i := 1 to numShapes do begin
        shapes[i]^.draw(dc); (* forward all messages *)
    end;
end;

function picture.contains(ident : string) : pointer;
var i : integer;
    tPointer : Pointer;
begin
    tPointer := inherited contains(ident);
    if(tPointer = NIL) then begin
        i := 1;
        while (i <= numShapes) and (tPointer = NIL) do begin
            tPointer := shapes[i]^.contains(ident); (* forward all messages *)
        end;
    end;
    contains := tPointer;
end;


begin
end.
