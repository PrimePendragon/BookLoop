-- ============================================================
-- BOOKLOOP - Testdaten
-- ============================================================

-- ============================================================
-- 01 - Rolle
-- Testdaten für die Entität: rolle
-- ============================================================

INSERT INTO rolle (rollenname, beschreibung) VALUES
('Benutzer', 'Standardrolle für registrierte Benutzer'),
('Administrator', 'Verwaltet Benutzer, Stammdaten und Plattform'),
('Moderator', 'Moderiert Bewertungen und Kommentare'),
('Support', 'Unterstützt Benutzer bei Problemen'),
('Redakteur', 'Pflegt Inhalte und Stammdaten'),
('Pruefer', 'Besitzt lesenden Zugriff für Prüfzwecke'),
('Gast', 'Besitzt eingeschränkten Zugriff'),
('Testbenutzer', 'Rolle für interne Funktionstests'),
('Datenpfleger', 'Pflegt Datenbestände der Plattform'),
('Systemverwaltung', 'Verwaltet technische Systemeinstellungen');

-- ============================================================
-- 02 - Benutzer
-- Testdaten für Benutzerkonten mit Zuordnung zu vorhandenen Rollen.
-- ============================================================

INSERT INTO benutzer
    (rolle_id, vorname, nachname, email, telefon, passwort_hash)
VALUES
    (1, 'Anna', 'Schmidt', 'anna.schmidt@example.de', '015112345601', 'hash_anna_01'),
    (1, 'Lukas', 'Weber', 'lukas.weber@example.de', '015112345602', 'hash_lukas_02'),
    (1, 'Sophie', 'Mueller', 'sophie.mueller@example.de', '015112345603', 'hash_sophie_03'),
    (1, 'Jonas', 'Fischer', 'jonas.fischer@example.de', '015112345604', 'hash_jonas_04'),
    (1, 'Laura', 'Wagner', 'laura.wagner@example.de', '015112345605', 'hash_laura_05'),
    (1, 'Felix', 'Becker', 'felix.becker@example.de', '015112345606', 'hash_felix_06'),
    (1, 'Marie', 'Hoffmann', 'marie.hoffmann@example.de', '015112345607', 'hash_marie_07'),
    (1, 'David', 'Koch', 'david.koch@example.de', '015112345608', 'hash_david_08'),
    (1, 'Julia', 'Richter', 'julia.richter@example.de', '015112345609', 'hash_julia_09'),
    (2, 'Max', 'Keller', 'max.keller@example.de', '015112345610', 'hash_max_10');
	
	-- ============================================================
-- 03 - Standort
-- Testdaten für Abholorte vorhandener Benutzer.
-- ============================================================

INSERT INTO standort
    (benutzer_id, bezeichnung, strasse, hausnummer, plz, ort,
     breitengrad, laengengrad, ist_standard)
VALUES
    (1, 'Zuhause', 'Musterstrasse', '12', '72070', 'Tuebingen', 48.521600, 9.057600, TRUE),
    (2, 'Zuhause', 'Gartenstrasse', '8', '72074', 'Tuebingen', 48.525400, 9.073200, TRUE),
    (3, 'Zuhause', 'Bahnhofstrasse', '21', '72764', 'Reutlingen', 48.491400, 9.204300, TRUE),
    (4, 'Zuhause', 'Hauptstrasse', '45', '72108', 'Rottenburg', 48.476800, 8.935300, TRUE),
    (5, 'Zuhause', 'Kirchstrasse', '7', '72072', 'Tuebingen', 48.503900, 9.054700, TRUE),
    (6, 'Zuhause', 'Schillerstrasse', '18', '72762', 'Reutlingen', 48.488100, 9.195500, TRUE),
    (7, 'Zuhause', 'Neckarstrasse', '30', '72072', 'Tuebingen', 48.510200, 9.062800, TRUE),
    (8, 'Zuhause', 'Uhlandstrasse', '14', '72108', 'Rottenburg', 48.474900, 8.936900, TRUE),
    (9, 'Zuhause', 'Lindenstrasse', '5', '72076', 'Tuebingen', 48.537100, 9.053900, TRUE),
    (1, 'Arbeitsplatz', 'Wilhelmstrasse', '25', '72074', 'Tuebingen', 48.524800, 9.059900, FALSE);
	
-- ============================================================
-- 04 - Autor
-- Testdaten für die Autoren der verwalteten Bücher.
-- ============================================================

INSERT INTO autor (vorname, nachname) VALUES
('J. K.', 'Rowling'),
('George', 'Orwell'),
('J. R. R.', 'Tolkien'),
('Jane', 'Austen'),
('Franz', 'Kafka'),
('Hermann', 'Hesse'),
('Agatha', 'Christie'),
('Stephen', 'King'),
('Cornelia', 'Funke'),
('Michael', 'Ende');

-- ============================================================
-- 05 - Verlag
-- Testdaten für die Verlage der verwalteten Bücher.
-- ============================================================

INSERT INTO verlag (verlagsname) VALUES
('Carlsen Verlag'),
('Fischer Verlag'),
('Rowohlt Verlag'),
('Suhrkamp Verlag'),
('Piper Verlag'),
('Heyne Verlag'),
('Klett-Cotta'),
('dtv Verlagsgesellschaft'),
('Penguin Verlag'),
('Bastei Luebbe');

-- ============================================================
-- 06 - Genre
-- Testdaten für die Klassifizierung der verwalteten Bücher.
-- ============================================================

INSERT INTO genre (bezeichnung) VALUES
('Fantasy'),
('Science-Fiction'),
('Krimi'),
('Thriller'),
('Roman'),
('Historischer Roman'),
('Sachbuch'),
('Biografie'),
('Kinderbuch'),
('Klassiker');	

-- ============================================================
-- 07 - Sprache
-- Testdaten für die Sprachen der verwalteten Bücher.
-- ============================================================

INSERT INTO sprache (bezeichnung) VALUES
('Deutsch'),
('Englisch'),
('Franzoesisch'),
('Spanisch'),
('Italienisch'),
('Portugiesisch'),
('Norwegisch'),
('Schwedisch'),
('Chinesisch'),
('Japanisch');

-- ============================================================
-- 08 - Buch
-- Testdaten für die bibliografischen Daten der Bücher.
-- ============================================================

INSERT INTO buch
    (autor_id, verlag_id, genre_id, sprache_id, titel, isbn, erscheinungsjahr, beschreibung)
VALUES
(1, 1, 1, 1, 'Harry Potter und der Stein der Weisen', '9783551551672', 1998, 'Erster Band der Harry-Potter-Reihe'),
(2, 2, 10, 1, '1984', '9783596903260', 1949, 'Dystopischer Roman über einen Überwachungsstaat'),
(3, 7, 1, 1, 'Der Herr der Ringe', '9783608939842', 1954, 'Fantasyroman über die Reise zur Vernichtung des Einen Rings'),
(4, 3, 10, 1, 'Stolz und Vorurteil', '9783499240812', 1813, 'Klassischer Gesellschaftsroman'),
(5, 4, 10, 1, 'Die Verwandlung', '9783518188132', 1915, 'Erzählung über die Verwandlung Gregor Samsas'),
(6, 5, 5, 1, 'Der Steppenwolf', '9783492251753', 1927, 'Roman über die innere Zerrissenheit des Protagonisten'),
(7, 6, 3, 1, 'Mord im Orient-Express', '9783453437708', 1934, 'Kriminalroman um den Ermittler Hercule Poirot'),
(8, 9, 4, 1, 'Es', '9783453435773', 1986, 'Horrorroman über eine Gruppe von Freunden'),
(9, 1, 9, 1, 'Tintenherz', '9783551551679', 2003, 'Fantasyroman für Kinder und Jugendliche'),
(10, 8, 9, 1, 'Die unendliche Geschichte', '9783423107132', 1979, 'Fantasyroman über die Welt Phantasien');

-- ============================================================
-- 09 - Zustand
-- Testdaten für die möglichen Zustände angebotener Bücher.
-- ============================================================

INSERT INTO zustand (bezeichnung, beschreibung) VALUES
('Neu', 'Unbenutztes Buch in neuwertigem Zustand'),
('Wie neu', 'Kaum Gebrauchsspuren, nahezu neuwertig'),
('Sehr gut', 'Leichte Gebrauchsspuren, insgesamt sehr guter Zustand'),
('Gut', 'Normale Gebrauchsspuren ohne größere Schäden'),
('Akzeptabel', 'Deutlich sichtbare Gebrauchsspuren, aber vollständig nutzbar'),
('Gebraucht', 'Mehrere sichtbare Gebrauchsspuren vorhanden'),
('Mit Markierungen', 'Enthält Markierungen oder Unterstreichungen'),
('Mit Notizen', 'Enthält handschriftliche Notizen'),
('Beschädigter Einband', 'Einband weist sichtbare Beschädigungen auf'),
('Sammlerstück', 'Besonderes oder älteres Exemplar mit Sammlerwert');

-- ============================================================
-- 10 - Angebot
-- Testdaten für konkrete Buchexemplare mit Zuordnung zu
-- Anbieter, Buch, Zustand und Abholstandort.
-- ============================================================

INSERT INTO angebot
    (anbieter_id, buch_id, zustand_id, standort_id,
     maximale_leihdauer_tage, abholung_moeglich,
     versand_moeglich, versandkosten, bemerkung)
VALUES
    (1, 1, 2, 1, 21, TRUE,  FALSE, NULL,  'Abholung nach Absprache'),
    (2, 2, 3, 2, 14, TRUE,  TRUE,  2.50,  'Versand innerhalb Deutschlands möglich'),
    (3, 3, 4, 3, 28, TRUE,  FALSE, NULL,  'Leichte Gebrauchsspuren'),
    (4, 4, 2, 4, 21, TRUE,  TRUE,  2.50,  'Sehr gepflegtes Exemplar'),
    (5, 5, 5, 5, 14, TRUE,  FALSE, NULL,  'Einige Gebrauchsspuren vorhanden'),
    (6, 6, 3, 6, 28, TRUE,  TRUE,  3.00,  'Versand nach Absprache'),
    (7, 7, 2, 7, 21, TRUE,  FALSE, NULL,  'Kaum Gebrauchsspuren'),
    (8, 8, 4, 8, 14, TRUE,  TRUE,  3.00,  'Abholung oder Versand möglich'),
    (9, 9, 3, 9, 28, TRUE,  FALSE, NULL,  'Gut erhaltenes Exemplar'),
    (1, 10, 4, 10, 21, TRUE, TRUE,  2.50,  'Abholung am Arbeitsplatz möglich');
	
-- ============================================================
-- 11 - Verfügbarkeit
-- Testdaten für die verfügbaren Zeiträume der Angebote.
-- ============================================================

INSERT INTO verfuegbarkeit
    (angebot_id, beginn, ende, verfuegbar)
VALUES
    (1,  '2026-09-01 09:00:00', '2026-09-01 18:00:00', TRUE),
    (2,  '2026-09-02 10:00:00', '2026-09-02 17:00:00', TRUE),
    (3,  '2026-09-03 08:00:00', '2026-09-03 16:00:00', TRUE),
    (4,  '2026-09-04 12:00:00', '2026-09-04 19:00:00', TRUE),
    (5,  '2026-09-05 09:30:00', '2026-09-05 15:30:00', TRUE),
    (6,  '2026-09-06 11:00:00', '2026-09-06 18:00:00', TRUE),
    (7,  '2026-09-07 14:00:00', '2026-09-07 20:00:00', TRUE),
    (8,  '2026-09-08 09:00:00', '2026-09-08 17:00:00', TRUE),
    (9,  '2026-09-09 10:30:00', '2026-09-09 18:30:00', TRUE),
    (10, '2026-09-10 08:30:00', '2026-09-10 16:30:00', TRUE);
	
-- ============================================================
-- 12 - Reservierung
-- Testdaten für Reservierungen vorhandener Angebote
-- durch registrierte Benutzer.
-- ============================================================

INSERT INTO reservierung
    (benutzer_id, angebot_id, reservierungsdatum, gueltig_bis, status)
VALUES
    (2,  1,  '2026-08-01 10:00:00', '2026-08-03 10:00:00', 'angenommen'),
    (3,  2,  '2026-08-02 11:30:00', '2026-08-04 11:30:00', 'angenommen'),
    (4,  3,  '2026-08-03 09:15:00', '2026-08-05 09:15:00', 'angenommen'),
    (5,  4,  '2026-08-04 14:00:00', '2026-08-06 14:00:00', 'angenommen'),
    (6,  5,  '2026-08-05 16:20:00', '2026-08-07 16:20:00', 'angenommen'),
    (7,  6,  '2026-08-06 12:45:00', '2026-08-08 12:45:00', 'angenommen'),
    (8,  7,  '2026-08-23 08:30:00', '2026-08-26 08:30:00', 'aktiv'),
    (9,  8,  '2026-08-23 13:10:00', '2026-08-27 13:10:00', 'aktiv'),
    (10, 9,  '2026-08-12 15:00:00', '2026-08-14 15:00:00', 'storniert'),
    (2, 10,  '2026-08-10 17:30:00', '2026-08-12 17:30:00', 'abgelaufen');
	
-- ============================================================
-- 13 - Ausleihe
-- Testdaten für Ausleihvorgänge mit und ohne vorherige
-- Reservierung.
-- ============================================================

INSERT INTO ausleihe
    (ausleiher_id, angebot_id, reservierung_id,
     ausleihdatum, faelligkeitsdatum, rueckgabedatum,
     versand, status)
VALUES
    (2, 1, 1, '2026-08-03', '2026-08-24', '2026-08-22', FALSE, 'zurueckgegeben'),
    (3, 2, 2, '2026-08-04', '2026-08-18', NULL, TRUE, 'ueberfaellig'),
    (4, 3, 3, '2026-08-05', '2026-09-02', NULL, FALSE, 'aktiv'),
    (5, 4, 4, '2026-08-06', '2026-08-27', NULL, TRUE, 'aktiv'),
    (6, 5, 5, '2026-08-07', '2026-08-21', '2026-08-20', FALSE, 'zurueckgegeben'),
    (7, 6, 6, '2026-08-08', '2026-09-05', NULL, TRUE, 'aktiv'),
    (8, 7, NULL, '2026-08-18', '2026-09-08', NULL, FALSE, 'aktiv'),
    (9, 8, NULL, '2026-08-19', '2026-09-02', NULL, TRUE, 'aktiv'),
    (10, 9, NULL, '2026-08-20', '2026-09-17', NULL, FALSE, 'aktiv'),
    (2, 10, NULL, '2026-08-21', '2026-09-11', NULL, TRUE, 'aktiv');

-- ============================================================
-- 14 - Bewertung
-- Testdaten für Bewertungen vorhandener Ausleihvorgänge.
-- ============================================================

INSERT INTO bewertung
    (ausleihe_id, sterne, kommentar)
VALUES
    (1, 5, 'Sehr guter Zustand und unkomplizierte Übergabe'),
    (2, 4, 'Buch entsprach der Beschreibung'),
    (3, 5, 'Sehr angenehme Ausleihe'),
    (4, 4, 'Schnelle und einfache Abwicklung'),
    (5, 5, 'Buch war in sehr gutem Zustand'),
    (6, 3, 'Ausleihe insgesamt zufriedenstellend'),
    (7, 4, 'Unkomplizierte Übergabe'),
    (8, 5, 'Sehr gute Erfahrung'),
    (9, 4, 'Alles wie beschrieben'),
    (10, 5, 'Problemlose Ausleihe und Rückgabe');