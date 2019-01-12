Vorgehensweise Übung Messstation
================================

* Destruktor in `object` definieren

* `station` und `sensor` von `object` ableiten.

* `sensor` zunachst als konkrete Klasse implementieren

* Beziehung zwischen `station` und `sensor` definieren
  + `attach` und `detach` implementieren`.

* `station` um `run` und `tick_sensors` erweitern.

* In `sensor` Methode `tick` implementieren.

* Von `sensor` Klasse `temperature_sensor` ableiten.
  + Konsturuktoren `protected` machen
	+ Virtuelle Methode `on_tick` hinzufügen
	
* Klasse `actor` implementieren
  + Bidirektionale Beziehung `actor`/`sensor` implementieren.
	+ `notify`/`on_notify` hinzufügen. Zunächst `double`-Wert übertragen.
	
* Klasse `information` implementieren

* Nachrichten versenden
  + `sensor::notify_all_actors` implementieren
	+ 