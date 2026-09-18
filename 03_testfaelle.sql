-- ============================================================
-- BOOKLOOP - Testfaelle
-- ============================================================

-- ============================================================
-- 01 - Rolle
-- Prüft, ob alle angelegten Rollen korrekt gespeichert wurden.
-- ============================================================

SELECT
    rolle_id,
    rollenname,
    beschreibung
FROM rolle
ORDER BY rolle_id;

-- ============================================================
-- 02 - Benutzer
-- Testet die Benutzerkonten inklusive ihrer Rollenzuordnung.
-- ============================================================

SELECT
    b.benutzer_id,
    b.vorname,
    b.nachname,
    b.email,
    b.aktiv,
    r.rollenname
FROM benutzer b
JOIN rolle r
    ON b.rolle_id = r.rolle_id
ORDER BY b.benutzer_id;

-- ============================================================
-- 03 - Standort
-- Testet die gespeicherten Standorte inklusive
-- Zuordnung zum jeweiligen Benutzer.
-- ============================================================

SELECT
    s.standort_id,
    b.vorname,
    b.nachname,
    s.bezeichnung,
    s.strasse,
    s.hausnummer,
    s.plz,
    s.ort,
    s.land,
    s.ist_standard
FROM standort s
JOIN benutzer b USING (benutzer_id)
ORDER BY s.standort_id;

-- ============================================================
-- 04 - Autor
-- Prüft die gespeicherten Autoren und deren Stammdaten.
-- ============================================================

SELECT
    autor_id,
    vorname,
    nachname
FROM autor
ORDER BY autor_id;

-- ============================================================
-- 05 - Verlag
-- Prüft die gespeicherten Verlage und deren Stammdaten.
-- ============================================================

SELECT
    verlag_id,
    verlagsname
FROM verlag
ORDER BY verlag_id;

-- ============================================================
-- 06 - Genre
-- Prüft die gespeicherten Genres und deren Stammdaten.
-- ============================================================

SELECT
    genre_id,
    bezeichnung
FROM genre
ORDER BY genre_id;

-- ============================================================
-- 07 - Sprache
-- Prüft die gespeicherten Sprachen und deren Stammdaten.
-- ============================================================

SELECT
    sprache_id,
    bezeichnung
FROM sprache
ORDER BY sprache_id;

-- ============================================================
-- 08 - Buch
-- Prüft die gespeicherten Bücher inklusive der Zuordnung
-- zu Autor, Verlag, Genre und Sprache.
-- ============================================================

SELECT
    b.buch_id,
    b.titel,
    a.vorname,
    a.nachname,
    v.verlagsname,
    g.bezeichnung AS genre,
    s.bezeichnung AS sprache,
    b.erscheinungsjahr
FROM buch b
JOIN autor a USING (autor_id)
LEFT JOIN verlag v USING (verlag_id)
JOIN genre g USING (genre_id)
JOIN sprache s USING (sprache_id)
ORDER BY b.buch_id;

-- ============================================================
-- 09 - Zustand
-- Prüft die gespeicherten Buchzustände und deren Beschreibungen.
-- ============================================================

SELECT
    zustand_id,
    bezeichnung,
    beschreibung
FROM zustand
ORDER BY zustand_id;

-- ============================================================
-- 10 - Angebot
-- Prüft die gespeicherten Angebote inklusive Anbieter,
-- Buch, Zustand und Abholstandort.
-- ============================================================

SELECT
    a.angebot_id,
    b.vorname,
    b.nachname,
    bu.titel,
    z.bezeichnung AS zustand,
    s.ort,
    a.maximale_leihdauer_tage,
    a.versand_moeglich,
    a.status
FROM angebot a
JOIN benutzer b
    ON a.anbieter_id = b.benutzer_id
JOIN buch bu USING (buch_id)
JOIN zustand z USING (zustand_id)
LEFT JOIN standort s USING (standort_id)
ORDER BY a.angebot_id;

-- ============================================================
-- 11 - Verfügbarkeit
-- Prüft die Verfügbarkeitszeiträume und ordnet diese
-- den jeweiligen Buchangeboten zu.
-- ============================================================

SELECT
    v.verfuegbarkeit_id,
    v.angebot_id,
    b.titel,
    v.beginn,
    v.ende,
    v.verfuegbar
FROM verfuegbarkeit v
JOIN angebot a USING (angebot_id)
JOIN buch b USING (buch_id)
ORDER BY v.verfuegbarkeit_id;

-- ============================================================
-- 12 - Reservierung
-- Prüft die gespeicherten Reservierungen inklusive
-- Benutzer- und Angebotszuordnung.
-- ============================================================

SELECT
    r.reservierung_id,
    b.vorname,
    b.nachname,
    r.angebot_id,
    bu.titel,
    r.reservierungsdatum,
    r.gueltig_bis,
    r.status
FROM reservierung r
JOIN benutzer b USING (benutzer_id)
JOIN angebot a USING (angebot_id)
JOIN buch bu USING (buch_id)
ORDER BY r.reservierung_id;

-- ============================================================
-- 13 - Ausleihe
-- Prüft die gespeicherten Ausleihvorgänge inklusive
-- Benutzer-, Angebots- und Reservierungszuordnung.
-- ============================================================

SELECT
    a.ausleihe_id,
    b.vorname,
    b.nachname,
    a.angebot_id,
    bu.titel,
    a.reservierung_id,
    a.ausleihdatum,
    a.faelligkeitsdatum,
    a.rueckgabedatum,
    a.versand,
    a.status
FROM ausleihe a
JOIN benutzer b
    ON a.ausleiher_id = b.benutzer_id
JOIN angebot an USING (angebot_id)
JOIN buch bu USING (buch_id)
LEFT JOIN reservierung r USING (reservierung_id)
ORDER BY a.ausleihe_id;

-- ============================================================
-- 14 - Bewertung
-- Prüft die gespeicherten Bewertungen inklusive
-- zugehöriger Ausleihe, Benutzer und Buch.
-- ============================================================

SELECT
    bw.bewertung_id,
    bw.ausleihe_id,
    b.vorname,
    b.nachname,
    bu.titel,
    bw.sterne,
    bw.kommentar,
    bw.bewertungsdatum
FROM bewertung bw
JOIN ausleihe a USING (ausleihe_id)
JOIN benutzer b
    ON a.ausleiher_id = b.benutzer_id
JOIN angebot an USING (angebot_id)
JOIN buch bu USING (buch_id)
ORDER BY bw.bewertung_id;

-- ============================================================
-- NEGATIVTESTS UND FACHLICHE GRENZFÄLLE
-- ============================================================

-- ------------------------------------------------------------
-- NT01 - Ungültiger Verfügbarkeitszeitraum
-- Erwartetes Ergebnis:
-- Der INSERT wird abgelehnt, da das Ende vor dem Beginn liegt.
-- ------------------------------------------------------------

INSERT INTO verfuegbarkeit
    (angebot_id, beginn, ende, verfuegbar)
VALUES
    (1, '2026-09-10 18:00:00', '2026-09-10 12:00:00', TRUE);
	
-- ------------------------------------------------------------
-- NT02 - Ungültige maximale Leihdauer
-- Erwartetes Ergebnis:
-- Das UPDATE wird abgelehnt, da die Leihdauer größer als 0 sein muss.
-- ------------------------------------------------------------

UPDATE angebot
SET maximale_leihdauer_tage = -10
WHERE angebot_id = 1;

-- ------------------------------------------------------------
-- NT03 - Reservierung eines nicht verfügbaren Angebots
-- Erwartetes Ergebnis:
-- Der INSERT wird durch den Trigger abgelehnt, da Angebot 1
-- den Status 'reserviert' besitzt.
-- Die Negativtests sind gezielt einzeln auszuführen!
-- ------------------------------------------------------------

UPDATE angebot
SET status = 'reserviert'
WHERE angebot_id = 1;

INSERT INTO reservierung
    (benutzer_id, angebot_id, gueltig_bis, status)
VALUES
    (3, 1, '2026-09-15 18:00:00', 'aktiv');

-- Nach dem Negativtest wieder Ausgangszustand herstellen.
UPDATE angebot
SET status = 'verfuegbar'
WHERE angebot_id = 1;

-- ------------------------------------------------------------
-- NT04 - Foreign-Key-Verletzung
-- Benutzer mit einer nicht existierenden Rollen anlegen.
-- PostgreSQL lehnt ab aufgrund der bestehenden Fremdschlüssel-
-- beziehung zwischen benutzer.rolle_id und rolle.rolle_id.
-- ------------------------------------------------------------

INSERT INTO benutzer
    (rolle_id, vorname, nachname, email, passwort_hash)
VALUES
    (9999, 'Test', 'Fremdschluessel', 'fk-test@bookloop.de', 'testhash');
	
-- ------------------------------------------------------------
-- NT05 - UNIQUE-Verletzung
-- Benutzer mit einer bereits vorhandenen E-Mail-Adresse
-- anlegen.
-- PostgreSQL lehnt den INSERT wegen des bestehenden 
-- UNIQUE-Constraints auf benutzer.email ab
-- ------------------------------------------------------------

INSERT INTO benutzer
    (rolle_id, vorname, nachname, email, passwort_hash)
VALUES
    (2, 'Test', 'Unique', 'anna.schmidt@example.de', 'testhash');

-- ------------------------------------------------------------
-- NT06 - PRIMARY KEY-Verletzung
-- Weil die Primärschlüssel als GENERATED ALWAYS AS IDENTITY 
-- erzeugt werden, kann nicht einfach normal eine beliebige 
-- ID eingesetzt werden. Für einen echten PK-Duplikat-Test
-- nutzen wir deshalb OVERRIDING SYSTEM VALUE.
-- PostgreSQL lehnt den Datensatz aufgrund der Eindeutigkeit
-- des Primärschlüssels ab.
-- ------------------------------------------------------------

INSERT INTO rolle
    (rolle_id, rollenname, beschreibung)
OVERRIDING SYSTEM VALUE
VALUES
    (1, 'Testrolle', 'Negativtest für Primärschlüssel');
	
-- ------------------------------------------------------------
-- NT07 - Ungültiger ENUM-Wert
-- Erwartetes Ergebnis:
-- Das UPDATE wird abgelehnt, da 'kaputt' kein gültiger Wert
-- des ENUM-Datentyps angebotstatus ist.
-- ------------------------------------------------------------

UPDATE angebot
SET status = 'kaputt'
WHERE angebot_id = 1;

-- ============================================================
-- KOMPLEXE ABFRAGEN UND AGGREGATIONEN
-- ============================================================

-- ------------------------------------------------------------
-- AG01 - Aktivste Nutzer
-- Ermittelt die Anzahl der Ausleihen pro Benutzer.
-- ------------------------------------------------------------
SELECT
    b.benutzer_id,
    b.vorname,
    b.nachname,
    COUNT(a.ausleihe_id) AS anzahl_ausleihen
FROM benutzer b
LEFT JOIN ausleihe a
    ON b.benutzer_id = a.ausleiher_id
GROUP BY
    b.benutzer_id,
    b.vorname,
    b.nachname
ORDER BY
    anzahl_ausleihen DESC,
    b.benutzer_id;

-- ------------------------------------------------------------
-- AG02 - Beliebteste Genres
-- ------------------------------------------------------------
SELECT
    g.genre_id,
    g.bezeichnung AS genre,
    COUNT(a.ausleihe_id) AS anzahl_ausleihen
FROM genre g
LEFT JOIN buch b
    USING (genre_id)
LEFT JOIN angebot an
    USING (buch_id)
LEFT JOIN ausleihe a
    USING (angebot_id)
GROUP BY
    g.genre_id,
    g.bezeichnung
ORDER BY
    anzahl_ausleihen DESC,
    g.genre_id;

-- ------------------------------------------------------------
-- AG03 - Durchschnittliche Ausleihdauer
-- ------------------------------------------------------------
SELECT
    COUNT(*) AS anzahl_abgeschlossene_ausleihen,
    ROUND(
        AVG(rueckgabedatum - ausleihdatum),
        2
    ) AS durchschnittliche_ausleihdauer_tage,
    MIN(rueckgabedatum - ausleihdatum) AS kuerzeste_ausleihe_tage,
    MAX(rueckgabedatum - ausleihdatum) AS laengste_ausleihe_tage
FROM ausleihe
WHERE rueckgabedatum IS NOT NULL;

-- ============================================================
-- NEGATIVTEST - Reservierung eines nicht verfügbaren Angebots
-- Erwartetes Ergebnis:
-- Die Reservierung wird durch den Trigger abgelehnt.
-- ============================================================

-- Angebot für den Test auf reserviert setzen
UPDATE angebot
SET status = 'reserviert'
WHERE angebot_id = 1;

-- Negativtest: Reservierung muss abgelehnt werden
INSERT INTO reservierung
    (benutzer_id, angebot_id, gueltig_bis, status)
VALUES
    (3, 1, '2026-09-15 18:00:00', 'aktiv');

-- Nach dem Negativtest wieder auf Ausgangszustand setzen
UPDATE angebot
SET status = 'verfuegbar'
WHERE angebot_id = 1;
