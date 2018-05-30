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
						CONSTRUCTOR Init(n : STRING; bd : Date);
						PROCEDURE SayName; VIRTUAL;
						FUNCTION GetBirthDate : Date;
				END; (* Class Person *)
SuperHero = ^SuperHeroObj;
SuperHeroObj = OBJECT(PersonObj)
				PRIVATE
                alterEgo : STRING;
                FUNCTION HasSkill(s: STRING): BOOLEAN;
				PUBLIC
					skills : SkillArray;
					CONSTRUCTOR Init(n : STRING; bd : Date; altEgo : STRING; skills : SkillArray);
					PROCEDURE UseSkill(s : STRING); VIRTUAL;
			END; (* Class Superhero *)
Villain = ^VillainObj;
VillainObj = OBJECT(PersonObj)
				PRIVATE
                    evilness : 1..10;
                    FUNCTION HasSkill(s: STRING): BOOLEAN;
				PUBLIC
					skills : SkillArray;
					CONSTRUCTOR Init(n : STRING; bd : Date; evilness : INTEGER; skills : SkillArray);
					PROCEDURE UseSkill(s : STRING); VIRTUAL;
			END; (* Class Villain *)

CONSTRUCTOR PersonObj.Init(n : STRING; bd : Date);
BEGIN
	name := n;
	birthDate := bd;
END;

PROCEDURE PersonObj.SayName;
BEGIN
	WriteLn('Hello my name is ', name);
END;

FUNCTION PersonObj.GetBirthDate: Date;
BEGIN
    GetBirthDate := birthDate;
END;

CONSTRUCTOR SuperheroObj.Init(n : STRING; bd : Date; altEgo : STRING; skills : SkillArray);
BEGIN
	INHERITED Init(n, bd); 
	alterEgo := altEgo;
	SELF.skills := skills; (* SELF represents the current object *)
END;

PROCEDURE SuperHeroObj.UseSkill(s: STRING);
BEGIN
    IF HasSkill(s) THEN BEGIN
        WriteLn('Using ', s, ' skill!');
    END;
END;

FUNCTION SuperHeroObj.HasSkill(s: STRING): BOOLEAN;
VAR i: INTEGER;
    hs: BOOLEAN;
BEGIN
    hs := FALSE;
    i := 1;
    WHILE (NOT hs) AND (i <= MAX_SKILLS) DO BEGIN
        hs := skills[i] = s;
        Inc(i);
    END;
    HasSkill := hs;
END;

CONSTRUCTOR VillainObj.Init(n : STRING; bd : Date; evilness : INTEGER; skills : SkillArray);
BEGIN
	INHERITED Init(n, bd); 
	SELF.evilness := evilness;
	SELF.skills := skills; (* SELF represents the current object *)
END;

PROCEDURE VillainObj.UseSkill(s: STRING);
BEGIN
    IF HasSkill(s) THEN BEGIN
        WriteLn('Using ', s, ' skill!');
    END;
END;

FUNCTION VillainObj.HasSkill(s: STRING): BOOLEAN;
VAR i: INTEGER;
    hs: BOOLEAN;
BEGIN
    hs := FALSE;
    i := 1;
    WHILE (NOT hs) AND (i <= MAX_SKILLS) DO BEGIN
        hs := skills[i] = s;
        Inc(i);
    END;
    HasSkill := hs;
END;

VAR sh: SuperHero;
    v: Villain;
    sa: SkillArray;
    d: Date;
    
BEGIN
    
    d.Day := 27;
    d.Month := 5;
    d.Year := 1949;

    sa[1] := 'Programming';
    sa[2] := 'Laser-Eyes';
    sa[3] := 'Teaching';
    sa[3] := 'Charming';
    
    New(sh, Init('Pomberger', d, 'Prof. Gust', sa));
    sh^.UseSkill('Charming');

    d.Day := 13;
    d.Month := 4;
    d.Year := 1976;

    sa[1] := 'Laser-Eyes';
    sa[2] := 'Exmatrikulation';
    
    New(v, Init('Endgegner', d, 8, sa));
    v^.SayName;
    v^.UseSkill('Laser-Eyes');

    WriteLn(SizeOf(v));
    WriteLn(SizeOf(VillainObj));
    
    Dispose(sh);
    Dispose(v);
END.
