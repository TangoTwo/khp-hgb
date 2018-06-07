#OOP in Pascal
* Information Hiding
* Vererbung
* Objekt
* Klasse  
	A <-- B  
		Bedeutet zwei Sachen:  
		* A vererbt an B  
		* B ist ein A  
* Polymorphismus (Vielgestaltigkeit)  
* Dynamische Bindung  
Uberlegung: Was ist dynamische Bindung? KlausurKlassiker  
	Bsp dyn. Bindung  
		~~~~~~~
			TYPE
			A = ^AObj;
			AObj = OBJECT
					PROCEDURE Print;
					END;
			B = ^BObj;
			BObj = OBJECT(AObj)
					PROCEDURE Print;
					END;
			PROCEDURE AObj.Print;VIRTUAL;
			BEGIN
				WriteLn('A');
			END;
			PROCEDURE BObj.Print;VIRTUAL;
			BEGIN
				WriteLn('B');
			END;
			
			VAR 
				b0 : B;
				a0 : A;
			BEGIN
				New(b0); // Erzeugt Objekt am Heap
				New(a0); // -||-
				b0^.Print;	// Aufruf der Methode Print
				a0^.Print;
				a0 := b0;
				a0^.Print; // ist dyn gebunden --> Ausgabe B!
		~~~~~~~
		vTable	-	Tabelle für 'virtuelle' Methoden
			Klasse | Methodenname | Sprungtabelle
			A | Print | 0x123
			B | Print | 0xABC
			```haskell
				qsort [] = []
			```