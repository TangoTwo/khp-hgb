ALTER TABLE Zutat
ADD CONSTRAINT fk_Einheit
FOREIGN KEY (Bezeichnung) REFERENCES Einheit(Bezeichnung);
