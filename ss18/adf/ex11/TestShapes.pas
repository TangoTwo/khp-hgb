program TestShapes;
uses ModShapes, Windows, CRT, WinGraph;

procedure drawShapes(dc : HDC; wnd: HWnd, re: TRect);
var l, lbl, lbr, lhl, lhr : line;
	c : circle;
	r : rectangle;
	pic : picture;

	p, q : pointRec;	
begin
	new(pic, init);

	p.x := 100; p.y := 100;
	q.x := 100; q.y := 300;
	new(l, init(p, q));

	p.x := 100, p.y := 0;
	new(c, init(p, 100));

	p.x := 0; p.y := 400;
	q.x := 200; q.y := 450;
    new(r, init(p, q)); (*rectangle*)

    p.x := 30; p.y := 400;
	q.x := 100; q.y := 300;
    new(lbl, init(p, q));

    p.x := 170; p.y := 400;
	q.x := 100; q.y := 300;
    new(lbr, init(p, q));

    p.x := 30; p.y := 150;
	q.x := 100; q.y := 200;
    new(lhl, init(p, q));

    p.x := 30; p.y := 150;
	q.x := 100; q.y := 200;
    new(lhr, init(p, q)); 
    
	pic.add(l);
	pic.add(c);
    pic.add(r);
    pic.add(lbl);
    pic.add(lbr);
    pic.add(lhl);
    pic.add(lhr);
	pic.move(100, 150);

    repeat
        fillRect(dc, re, 0);
        pic.draw(dc);
        pic.move(10, 0);
        delay(100);
    until FALSE;

	Dispose(pic);
	Dispose(l);
	Dispose(c);
	Dispose(r);	
end; (*DrawShapes *)

begin
	redrawproc := drawShapes;
	WGMain; (*enter event processing loop*)
end.
