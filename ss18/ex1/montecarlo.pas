program montecarlo;

type
	point = array[real] of 0..2;
var
	countInEllipse : integer;
	n : integer;
	i : integer;
	x, y, z : real;
	f1, f2 : point;
	distSum: real;

function Volume(f1, f2 : point;
				distSum: real) : real;
begin
	countInEllipse := 0;
	n := 1000;
	(* Using Monte Carlo Method *)
	for i := 1 to n do begin
		x := random(distSum);
		y := random(distSum);
		z := random(distSum);
		if((sqrt(sqr(f1[0]-x)+sqr(f1[1]-y)+sqr(f1[2]-z))+sqrt(sqr(f2[0]-x)+sqr(f2[1]-y)+sqr(f2[2]-z)))<=distSum) then
			inc(countInEllipse);
	end;
	writeln('Ellipse is approx.:', boundingbox * (countInEllipse/n));
end;
	distSum := 20.0;
	f1[0] := 2;
	f1[1] := 2;
	f1[2] := 2;
	f2[0] := -2;
	f2[1] := -2;
	f2[2] := -2;
	Volume(f1, f2, distSum);
begin
	