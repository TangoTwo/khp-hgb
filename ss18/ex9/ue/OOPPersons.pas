PROGRAM OOPPeople;

CONST MAX_SKILLS = 10;

TYPE
	Date = RECORD
			day, month, year : INTEGER;
		END;
	SkillArray = ARRAY [1..MAX_SKILLS] OF STRING;
	Person = ^PersonObj;
	PersonObj = OBJECT
					name : STRING;
					PRIVATE
						birthDate : Date;
					PUBLIC
						CONSTRUCTOR Init(n : STRING; gd : Date);
						PROCEDURE SayName; VIRTUAL;
						FUNCTION GetBirthDate : Date;
				END; (* Class Person *)
SuperHero = ^SuperHeroObj;
SuperHeroObj = OBJECT(PersonObj)
				PRIVATE
					alterEgo : STRING;
				PUBLIC
					skills : SkillArray;
					CONSTRUCTOR Init(n : STRING; bd : Date; alterEgo : STRING, skills : SkillArray);
					PROCEDURE UseSkill(s : STRING); VIRTUAL;
			END; (* Class Superhero *)
Villain = ^VillainObj;
VillainObj = OBJECT(PersonObj)
				PRIVATE
					evilness : 1..10;
				PUBLIC
					skills : SkillArray;
					CONSTRUCTOR Init(n : STRING; bd : Date; evilness : INTEGER, skills : SkillAray);
					PROCEDURE UseSkill(s : STRING); VIRTUAL;
			END; (* Class Villain *)

CONSTRUCTOR PersonObj.Init(n : STRING, bd : Date);
BEGIN
	name := n;
	birthDate := bd;
END;

PROCEDURE PersonObj.SayName;
BEGIN
	WriteLn('Hello my name is', name);
END;

CONSTRUCTOR Superhero.Init(n : STRING, bd : Date, altEgo : STRING, skills : SkillArray);
BEGIN
	INHERITED Init(n, bd); 
	alterEgo := altEgo;
	SELF.skills := skills; (* SELF represents the current object *)
END;

...

BEGIN	
END.