CREATE TABLE Einheit (
    Bezeichnung VARCHAR(20),
    CONSTRAINT pk_Bezeichnung PRIMARY KEY (Bezeichnung)
);

CREATE TABLE EinheitEinheit(
    BezeichnungVon VARCHAR(20),
    BezeichnungZu VARCHAR(20),
    Umrechnungsfaktor NUMBER,
    CONSTRAINT pk_EinheitEinheit PRIMARY KEY(BezeichnungVon, BezeichnungZu)
);

CREATE TABLE Zutat(
Name VARCHAR(20),
VorbVariante VARCHAR(20),
EinheitBezeichnung VARCHAR(20),
CONSTRAINT pk_Zutat PRIMARY KEY(Name, VorbVariante)
);

CREATE TABLE Rezept(
Name VARCHAR(20),
VorbVariante VARCHAR(20),
PersonName VARCHAR(20),
Anzahl NUMBER,
Beschreibung VARCHAR(20)
CONSTRAINT pk_Rezept PRIMARY KEY(Name, VorbVariante)
);

CREATE TABLE Materialzutat(
Name VARCHAR(20),
VorbVariante VARCHAR(20),
CONSTRAINT pk_Materialzutat PRIMARY KEY(Name, VorbVariante)
);

CREATE TABLE Verwendet(
NameZutat VARCHAR(20),
VorbVarianteZutat VARCHAR(20),
NameRezept VARCHAR(20),
VorbVarianteRezept VARCHAR(20),
Menge NUMBER
CONSTRAINT pk_Verwendet PRIMARY KEY(NameZutat, VorbVarianteZutat, NameRezept, VorbVarianteRezept)
);

CREATE TABLE Person(
Name VARCHAR(20)
CONSTRAINT pk_Person PRIMARY KEY(Name)
);

CREATE TABLE Bewertung(
BewertungsID NUMBER,
Datum DATE,
PersonName VARCHAR(20),
RezeptName VARCHAR(20),
Kommentar VARCHAR(100),
LeckerFaktor NUMBER,
Einfachheit NUMBER,
CONSTRAINT pk_Bewertung PRIMARY KEY(BewertungsID)
);

CREATE TABLE Schlagwort(
Wort VARCHAR(20)
CONSTRAINT pk_Schlagwort PRIMARY KEY(Wort)
);

CREATE TABLE beschreibt(
Schlagwort VARCHAR(20),
RezeptName VARCHAR(20),
CONSTRAINT pk_beschreibt PRIMARY KEY(Schlagwort, RezeptName)
);

CREATE TABLE Bild(
BildID NUMBER,
Name VARCHAR(20),
Verzeichnus VARCHAR(20),
CONSTRAINT pk_Bild PRIMARY KEY(BildID)
);

CREATE TABLE Kochanweisung(
KochanweisungID NUMBER,
Text VARCHAR(20),
CONSTRAINT pk_Kochanweisung PRIMARY KEY(KochanweisungID)
);

CREATE TABLE zeigtRezept(
BildID NUMBER,
RezeptName VARCHAR(20),
Reihenfolge NUMBER,
CONSTRAINT pk_zeigtRezept PRIMARY KEY(BildID, RezeptName)
);

CREATE TABLE zeigtKochanweisung(
BildID NUMBER,
KochanweisungID NUMBER,
Reihenfolge NUMBER,
CONSTRAINT zeigtKochanweisung PRIMARY KEY(BildID, KochanweisungID)
);
CREATE TABLE bestehtAus(
KochanweisungID NUMBER,
RezeptName VARCHAR(20),
Reihenfolge NUMBER,
CONSTRAINT pk_ PRIMARY KEY(KochanweisungID, RezeptName)
);
