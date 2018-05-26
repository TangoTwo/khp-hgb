PROGRAM OOPDemo;

TYPE
	A = ^AObj;
	AObj = OBJECT (* this is a class definition!! *)
			val : INTEGER;
			CONSTRUCTOR Init;
			PROCEDURE Print; VIRTUAL; (* VIRTUAL <-- dynamically linked *)
		END;

B = ^BObj;
BObj = OBJECT(AObj)
		(*val in inherited *)
		CONSTRUCTOR Init;
		PROCEDURE Print; VIRTUAL; (* overwrite PRINT from A *)
	END;

CONSTRUCTOR AObj.Init;
BEGIN
	val := 4;
END;

PROCEDURE AObj.Print;
BEGIN
	WriteLn('A', val);
END;

CONSTRUCTOR BObj.Init;
BEGIN
	val := 8; (* val is defined in A and inherited in B *)
END;

PROCEDURE BObj.Print;
BEGIN
	WriteLn('B', val);
END;

VAR
	a0 : A;
	b0 : B;

	sa0 : AObj;
	sb0 : BObj;

BEGIN
	New(a0, Init); (* call constructor Init after allocation memory for the object *)
	New(b0, Init);
	a0^.Print;
	b0^.Print;
	Dispose(a0); (* object is not needed anymore *)
	b0^.val := 17;
	a0 := b0;
	a0^.Print; (*B 17 *)
	a0^.val := 21;
	a0^.Print; (* B 21 *)
	b0^.Print; (* B 21 *)

	sa0.Init;
	sb0.Init;
	sa0.Print;
	sb0.Print;
	sb0.val := 17;
	sa0 := sb0;
	sa0.Print; (* B 17 ! *)
	sa0.val := 21;
	sb0.Print; (* B 17*)
	sa0.Print (* B 21 !*)
END.
