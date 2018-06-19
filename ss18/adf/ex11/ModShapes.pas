unit modShapes;

interface

USES Windows, WinGraph, sysutils; (* for HDC *)
    
const
    MAX = 254;

type
	pointRec = record
				x : integer;
				y : integer;
            end;
    shape = ^shapeObj;
	shapeObj = object
                visible : boolean;
                name : string;
				procedure move(mx, my : integer); virtual; abstract; (* abstract methods have no definition *)
				procedure write; virtual; abstract;
				procedure draw(dc : HDC); virtual; abstract;
                function contains(ident : string) : shape; virtual;
                procedure setVisible(visible : boolean); virtual;
			end;
	shapeArray = array[1..MAX] of shape;
    line = ^lineObj;
	lineObj = object(shapeObj)
				private
					startP, endP : PointRec;
				public
					constructor init(tStartP, tEndP : pointRec; ident : string);
					procedure move(mx, my : integer); virtual;
                    procedure write; virtual; 
                    procedure draw(dc : HDC); virtual;
			end;
    rectangle = ^rectangleObj;
	rectangleObj = object(shapeObj)
					private
						p0, p1, p2, p3 : pointRec;
					public
						constructor init(lt, rb : pointRec; ident : string);
						procedure move(mx, my : integer); virtual;
                        procedure write; virtual;
                        procedure draw(dc : HDC); virtual;
				end;
    circle = ^circleObj;
	circleObj = object(shapeObj)
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
    picture = ^pictureObj;
	pictureObj = object(shapeObj)
					private
						shapes : shapeArray;
						numShapes : integer;
					public
						constructor init(ident : string);
						procedure move(mx, my : integer); virtual;
						procedure add(s : shape);
                        procedure write; virtual;
                        procedure draw(dc : HDC); virtual;
                        function contains(ident : string) : shape; virtual;
			procedure setVisible(visible : boolean); 
virtual;
                    end;

implementation

procedure addToPoint(var p : pointRec; x, y : integer);
begin
	p.x := p.x + x;
	p.y := p.y + y;
end;

(***************Shape**************)
function shapeObj.contains(ident : string) : shape;
begin
    ident := upperCase(ident);
    if(name = ident) then
        contains := @self
    else
        contains := NIL;
end;
procedure shapeObj.setVisible(visible : boolean);
begin
    self.visible := visible;
end;
(***************Line***************)
constructor lineObj.init(tStartP, tEndP : PointRec; ident : string);
begin
    self.name := upperCase(ident);
	self.startP := tStartP;
	self.endP := tEndP;
	visible := TRUE;
end;

procedure lineObj.move(mx, my : integer);
begin
	addToPoint(startP, mx, my);
	addToPoint(endP, mx, my);
end;

procedure lineObj.write;
begin
	//writeLn('Line from ', startP.x, ',', startP.y, ') to (', endP.x, ',' endP.y, ')');
end;

procedure lineObj.draw(dc : HDC);
begin
    if not visible then exit;
    moveTo(dc, startP.x, startP.y);
    lineTo(dc, endP.x, endP.y);
end;

(************************RECTANGLE*****************)
constructor rectangleObj.init(lt, rb : PointRec; ident : string);
begin
    self.name := ident;
	p0 := lt;
	p2 := rb;
	p1.x := p2.x;
	p1.y := p0.y;
	p3.x := p0.x;
	p3.y := p2.y;
end;

procedure rectangleObj.move(mx, my : integer);
begin
	addToPoint(p0, mx, my);
	addToPoint(p1, mx, my);
	addToPoint(p2, mx, my);
	addToPoint(p3, mx, my);
end;

procedure rectangleObj.write;
begin
	writeLn('Rectangle: ');
	writeLn('(', p0.x,',', p0.y,')');
end;

procedure rectangleObj.draw(dc : HDC);
begin
    if not visible then exit;
    moveTo(dc, p0.x, p0.y);
    lineTo(dc, p1.x, p1.y);
    lineTo(dc, p2.x, p2.y);
    lineTo(dc, p3.x, p3.y);
    lineTo(dc, p0.x, p0.y);
end;

(*********************Circle****************************)
constructor circleObj.init(c: pointRec; r : integer; ident : string);
begin
    self.name := ident;
	self.center := c;
	self.radius := r;
	visible := TRUE;
end;

procedure circleObj.move(mx, my : integer);
begin
	addToPoint(center, mx, my);
end;

procedure circleObj.write;
begin
	writeLn('Circle with center: (', center.x, ',', center.y, ') radius: ', radius);
end;

procedure circleObj.draw(dc : HDC);
begin
    if not visible then exit;
    Ellipse(dc, center.x - radius, center.y - radius,
          center.x + radius, center.y + radius);
end;

(********************PICTURE**************************)
constructor pictureObj.init(ident : string);
begin
    self.name := ident;
	numShapes := 0;
	visible := TRUE;
end;

procedure pictureObj.move(mx, my : integer);
var i : integer;
begin
	for i := 1 to numShapes do
		shapes[i]^.move(mx, my);
end;

procedure pictureObj.add(s : shape);
begin
	if numShapes >= MAX then begin
		writeLn('Picture is full');
		halt;
	end;
	if s = @self then begin
		writeLn('Cannot add picture to itself');
		halt;
	end;
	inc(numShapes);
	shapes[numShapes] := s;
end;

procedure pictureObj.write;
var i : integer;
begin
	writeLn('Picture with ', numShapes, ' shapes: ');
	for i := 1 to numShapes do
		shapes[i]^.write;
end;

procedure pictureObj.draw(dc : HDC);
var i : integer;
begin
    if not visible then exit;
    for i := 1 to numShapes do begin
        shapes[i]^.draw(dc); (* forward all messages *)
    end;
    sleep(5);
end;

procedure pictureObj.setVisible(visible : boolean);
var i : integer;
begin
	i := 1;
	while (i <= numShapes) do begin
		shapes[i]^.setVisible(visible);
		inc(i);
	end;
end;

function pictureObj.contains(ident : string) : shape;
var i : integer;
    tPointer : shape;
begin
    tPointer := inherited contains(ident);
    if(tPointer = NIL) then begin
        i := 1;
        while (i <= numShapes) and (tPointer = NIL) do begin
            tPointer := shapes[i]^.contains(ident); (* forward all messages *)
            inc(i);
        end;
    end;
    contains := tPointer;
end;

begin
end.
