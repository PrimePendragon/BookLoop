# BookLoop

## 1. Projektbeschreibung

BookLoop ist eine relationale PostgreSQL-Datenbank für eine Plattform zur gemeinschaftlichen Ausleihe von Büchern.

Benutzer können Bücher als Angebote zur Verfügung stellen, verfügbare Angebote reservieren und Bücher ausleihen. Zusätzlich verwaltet das System Standorte, zeitliche Verfügbarkeiten und Bewertungen zu vorhandenen Ausleihvorgängen.

Das relationale Datenmodell umfasst 14 miteinander verknüpfte Tabellen.

## 2. Systemvoraussetzungen

- PostgreSQL 18
- pgAdmin 4, Version 9.11

## 3. Datenbank einrichten

Die SQL-Dateien werden in folgender Reihenfolge ausgeführt:

1. `01_schema.sql`
2. `02_testdaten.sql`
3. `03_testfaelle.sql`

`01_schema.sql` erstellt das vollständige Datenbankschema mit Tabellen, ENUM-Datentypen, Constraints, Trigger und Indizes.

`02_testdaten.sql` befüllt jede der 14 Tabellen mit jeweils 10 Testdatensätzen.

`03_testfaelle.sql` enthält Abfragen sowie Positiv- und Negativtests zur Überprüfung der Datenbank. Die einzelnen Tests sollten separat ausgeführt werden.

Eine ausführliche Beschreibung der Einrichtung befindet sich in `Installationsanleitung.pdf`.

## 4. Testfälle

Die Testfälle überprüfen unter anderem Primär- und Fremdschlüssel, UNIQUE-Constraints, CHECK-Constraints, ENUM-Werte sowie die Triggerprüfung bei Reservierungen.

Die Fehlermeldungen der Negativtests sind beabsichtigt. Sie zeigen, dass ungültige Daten durch die definierten Schutzmechanismen abgelehnt werden.

Zusätzlich enthält `03_testfaelle.sql` JOIN-Abfragen und Aggregationen zur Auswertung der gespeicherten Daten.

## 5. Repositorystruktur

- `01_schema.sql` – Datenbankschema
- `02_testdaten.sql` – Testdaten
- `03_testfaelle.sql` – Testfälle und Abfragen
- `Installationsanleitung.pdf` – Installationsanleitung
- `docs/` – Berichte und Dokumentationen der Projektphasen

## 6. Autor

Brian Pudelko

IU Internationale Hochschule  
Studiengang Informatik  
Projekt: Data-Mart-Erstellung in SQL
