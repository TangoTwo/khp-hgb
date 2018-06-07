program montecarlo;

type
    point = array[0..2] of real;
var
	f1, f2 : point;
    distSum: real;
    n : longint;

procedure centerEllipse(var f1, f2 : point); (* Moves the f1 and f2 point so that they are connected via the x-axis *)
var
    distance : real;
begin
    distance := sqrt(sqr(f1[0]-f2[0])+sqr(f1[1]-f2[1])+sqr(f1[2]-f2[2])); (*Distance between f1 and f2 *)
    f1[0] := -(distance/2);
    f1[1] := 0;
    f1[2] := 0;
    f2[0] := (distance/2);
    f2[1] := 0;
    f2[2] := 0;
end;

procedure boundingBoxCalc(f1, f2 : point;
                          distSum : real;
                          var boundingBoxXLength, boundingBoxYLength, boundingBoxZLength : real;
                          var boundingBoxVol : real); (*Calculates the bounding box *)
begin
    boundingBoxXLength := distSum;
    boundingBoxYLength := boundingBoxXLength;
    boundingBoxZLength := boundingBoxYLength;
    boundingBoxVol := boundingBoxXLength * boundingBoxYLength * boundingBoxZLength;
end;

function Volume(f1, f2 : point;
                distSum: real) : real;
var
    countInEllipse : longint;
	i : longint;
    x, y, z : real;
    boundingBoxXLength : real;
    boundingBoxYLength : real;
    boundingBoxZLength : real;
    boundingBoxVol : real;
begin
	countInEllipse := 0;
    centerEllipse(f1, f2);
    boundingBoxCalc(f1, f2, distSum, boundingBoxXLength, boundingBoxYLength, boundingBoxZLength, boundingBoxVol);
	(* Using Monte Carlo Method *)
	for i := 1 to n do begin
		x := random()*boundingBoxXLength-boundingBoxXLength/2;
		y := random()*boundingBoxYLength-boundingBoxYLength/2;
		z := random()*boundingBoxZLength-boundingBoxZLength/2;
		if((sqrt(sqr(f1[0]-x)+sqr(f1[1]-y)+sqr(f1[2]-z))+sqrt(sqr(f2[0]-x)+sqr(f2[1]-y)+sqr(f2[2]-z)))<=distSum) then
            inc(countInEllipse);
	end;
	Volume := boundingBoxVol * (countInEllipse/n);
end;
begin
	distSum := 2.0;
	f1[0] := 1.0;
	f1[1] := 1.0;
	f1[2] := 1.0;
	f2[0] := 1.0;
	f2[1] := 1.0;
    f2[2] := 1.0;
    n := 10;
    writeln('Volume for n = ', n, ' is', Volume(f1, f2, distSum));
    n := 100;
    writeln('Volume for n = ', n, ' is', Volume(f1, f2, distSum));
    n := 1000;
    writeln('Volume for n = ', n, ' is', Volume(f1, f2, distSum));
    n := 10000;
    writeln('Volume for n = ', n, ' is', Volume(f1, f2, distSum));
    n := 100000;
    writeln('Volume for n = ', n, ' is', Volume(f1, f2, distSum));
    n := 1000000;
    writeln('Volume for n = ', n, ' is', Volume(f1, f2, distSum));
end.
