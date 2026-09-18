
# BookLoop

BookLoop ist eine relationale PostgreSQL-Datenbank für eine Plattform zur gemeinschaftlichen Ausleihe von Büchern. Benutzer können Bücher als Angebote zur Verfügung stellen, verfügbare Angebote reservieren und Bücher ausleihen.

Das Datenmodell umfasst 14 miteinander verknüpfte Tabellen und bildet unter anderem Benutzer, Bücher, Angebote, Verfügbarkeiten, Reservierungen, Ausleihen und Bewertungen ab.

## Systemvoraussetzungen

- PostgreSQL 18
- pgAdmin 4, Version 9.11

## SQL-Dateien

- `01_schema.sql` – Erstellt das vollständige Datenbankschema mit Tabellen, ENUM-Datentypen, Constraints, Trigger und Indizes.
- `02_testdaten.sql` – Befüllt jede der 14 Tabellen mit jeweils 10 Testdatensätzen.
- `03_testfaelle.sql` – Enthält Abfragen sowie Positiv- und Negativtests zur Überprüfung der Datenbank.

## Installation

1. Eine neue PostgreSQL-Datenbank mit dem Namen `BookLoop` erstellen.
2. `01_schema.sql` vollständig ausführen.
3. `02_testdaten.sql` vollständig ausführen.
4. Die Tests aus `03_testfaelle.sql` einzeln ausführen.

Die Negativtests in `03_testfaelle.sql` erzeugen bewusst Fehlermeldungen. Damit wird überprüft, ob die definierten Constraints und Schutzmechanismen ungültige Daten korrekt ablehnen.

Eine ausführliche Beschreibung der Einrichtung befindet sich in `Installationsanleitung.pdf`.

## Repository-Inhalt

- `01_schema.sql` – Datenbankschema
- `02_testdaten.sql` – Testdaten
- `03_testfaelle.sql` – Testfälle und Abfragen
- `Installationsanleitung.pdf` – Anleitung zur Einrichtung und Ausführung
- `docs/` – Dokumente und Berichte aus den Projektphasen
  
