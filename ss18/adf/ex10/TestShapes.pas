program TestShapes;
uses ModShapes;

var l : line;
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

	p.x := 0; p.y := 500;
	q.x := 200; q.y := 550;
	new(r, init(p, q)); (*rectangle*)	

	pic.add(l);
	pic.add(c);
	pic.add(r);
	pic.move(100, 150);

	pic.write;	
end.