unit modShapes;


interface
	const
		MAX = 10;

type
	pointRec = record
				x : integer;
				y : integer;
			end;
	shape = class
				visible : boolean;
				procedure move(mx, my : integer); virtual; abstract; (* abstract methods have no definition *)
				procedure write; virtual;
			end;
	shapes = array[1..MAX] of shape;
	line = class(shape)
				private
					startP, endP : PointRec;
				public
					constructor init(startP, endP : pointRec);
					procedure move(mx, my : integer); virtual;
					procedure write; virtual;
			end;

	rectangle = class(shape)
					private
						p0, p1, p2, p3 : pointRec;
					public
						constructor init(lt, rb : pointRec);
						procedure move(mx, my, : integer); virtual;
						procedure write; virtual;
				end;
	circle = class(shape)
					private
						center : pointRec;
						radius : integer;
					public
						constructor init(c : pointRec;
										 r : integer);
						procedure move(mx, my : integer); virtual;
						procedure write; virtual;
				end;

	picture = class(shape)
					private
						shapes : shapeArray;
						numShapes : integer;
					public
						constructor init;
						procedure move(mx, my : integer); virtual;
						procedure add(s : shape);
						procedure write; virtual;
				end;

implementation

procedure addToPoint(var p : pointRec; x, y : integer);
begin
	p.x := p.x + x;
	p.y := p.y + y;
end;

(***************Line***************)
constructor lineObj.init(startP, endP : PointRec);
begin
	self.startP := startP;
	self.endP := endP;
	visible := TRUE;
end;

procedure lineObj.move(mx, my : integer);
begin
	addToPoint(startP, mx, my);
	addToPoint(endP, mx, my);
end;

procedure line.write;
begin
	writeLn('Line from ', startP. x, ',', startP.y, ') to (', endP.x, ',' endP.y, ')');
end;
(************************RECTANGLE*****************)
constructor rectangle.init(lt, rb : PointRec);
begin
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

(*********************Circle****************************)
constructor circle.init(c: pointRec; r : integer);
begin
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

(********************PICTURE**************************)
constructor picture.init;
begin
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


begin
end.