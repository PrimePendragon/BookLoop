-- ============================================================
-- BOOKLOOP - DATENBANKSCHEMA
-- ============================================================


-- ============================================================
-- 01 - Rolle
-- Speichert die unterschiedlichen Benutzerrollen von BookLoop,
-- z. B. Benutzer und Administrator.
-- ============================================================

CREATE TABLE rolle (
    rolle_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rollenname VARCHAR(50) NOT NULL UNIQUE,
    beschreibung VARCHAR(255)
);

-- ============================================================
-- 02 - Benutzer
-- Speichert die Benutzerkonten von BookLoop und ordnet
-- jedem Benutzer über rolle_id eine Rolle zu.
-- ============================================================

CREATE TABLE benutzer (
    benutzer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rolle_id INTEGER NOT NULL,
    vorname VARCHAR(100) NOT NULL,
    nachname VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefon VARCHAR(30),
    passwort_hash VARCHAR(255) NOT NULL,
    registrierungsdatum TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    aktiv BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_benutzer_rolle
        FOREIGN KEY (rolle_id)
        REFERENCES rolle(rolle_id)
);

-- ============================================================
-- 03 - Standort
-- Speichert die Abholorte der Benutzer und ermöglicht
-- eine spätere räumliche Suche nach Buchangeboten.
-- ============================================================

CREATE TABLE standort (
    standort_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    benutzer_id INTEGER NOT NULL,
    bezeichnung VARCHAR(100),
    strasse VARCHAR(150) NOT NULL,
    hausnummer VARCHAR(20) NOT NULL,
    plz VARCHAR(10) NOT NULL,
    ort VARCHAR(100) NOT NULL,
    land VARCHAR(100) NOT NULL DEFAULT 'Deutschland',
    breitengrad DECIMAL(9,6),
    laengengrad DECIMAL(9,6),
    ist_standard BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT fk_standort_benutzer
        FOREIGN KEY (benutzer_id)
        REFERENCES benutzer(benutzer_id)
);

-- ============================================================
-- 04 - Autor
-- Speichert die Autoren der in BookLoop verwalteten Bücher.
-- ============================================================

CREATE TABLE autor (
    autor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vorname VARCHAR(100),
    nachname VARCHAR(100) NOT NULL
);

-- ============================================================
-- 05 - Verlag
-- Speichert die Verlage der in BookLoop verwalteten Bücher.
-- ============================================================

CREATE TABLE verlag (
    verlag_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    verlagsname VARCHAR(150) NOT NULL UNIQUE
);

-- ============================================================
-- 06 - Genre
-- Speichert die Genres zur Klassifizierung der Bücher.
-- ============================================================

CREATE TABLE genre (
    genre_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    bezeichnung VARCHAR(100) NOT NULL UNIQUE
);

-- ============================================================
-- 07 - Sprache
-- Speichert die verfügbaren Sprachen der verwalteten Bücher.
-- ============================================================

CREATE TABLE sprache (
    sprache_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    bezeichnung VARCHAR(100) NOT NULL UNIQUE
);

-- ============================================================
-- 08 - Buch
-- Speichert die bibliografischen Daten der verwalteten Bücher
-- und verknüpft diese mit Autor, Verlag, Genre und Sprache.
-- ============================================================

CREATE TABLE buch (
    buch_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    autor_id INTEGER NOT NULL,
    verlag_id INTEGER,
    genre_id INTEGER NOT NULL,
    sprache_id INTEGER NOT NULL,
    titel VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    erscheinungsjahr INTEGER,
    beschreibung TEXT,

    CONSTRAINT fk_buch_autor
        FOREIGN KEY (autor_id)
        REFERENCES autor(autor_id),

    CONSTRAINT fk_buch_verlag
        FOREIGN KEY (verlag_id)
        REFERENCES verlag(verlag_id),

    CONSTRAINT fk_buch_genre
        FOREIGN KEY (genre_id)
        REFERENCES genre(genre_id),

    CONSTRAINT fk_buch_sprache
        FOREIGN KEY (sprache_id)
        REFERENCES sprache(sprache_id)
);

-- ============================================================
-- 09 - Zustand
-- Speichert die möglichen Zustände eines angebotenen Buches.
-- ============================================================

CREATE TABLE zustand (
    zustand_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    bezeichnung VARCHAR(100) NOT NULL UNIQUE,
    beschreibung VARCHAR(255)
);

-- ============================================================
-- 10 - Angebot
-- Repräsentiert ein konkretes Buchexemplar, das von einem
-- Benutzer zum Verleih angeboten wird.
-- ============================================================

CREATE TYPE angebotstatus AS ENUM (
    'verfuegbar',
    'reserviert',
    'ausgeliehen',
    'deaktiviert'
);

CREATE TABLE angebot (
    angebot_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    anbieter_id INTEGER NOT NULL,
    buch_id INTEGER NOT NULL,
    zustand_id INTEGER NOT NULL,
    standort_id INTEGER,
    maximale_leihdauer_tage INTEGER NOT NULL,
    abholung_moeglich BOOLEAN NOT NULL DEFAULT TRUE,
    versand_moeglich BOOLEAN NOT NULL DEFAULT FALSE,
    versandkosten DECIMAL(8,2),
    status angebotstatus NOT NULL DEFAULT 'verfuegbar',
    einstelldatum TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    bemerkung TEXT,

    CONSTRAINT ck_angebot_leihdauer
        CHECK (maximale_leihdauer_tage > 0),

    CONSTRAINT fk_angebot_anbieter
        FOREIGN KEY (anbieter_id)
        REFERENCES benutzer(benutzer_id),

    CONSTRAINT fk_angebot_buch
        FOREIGN KEY (buch_id)
        REFERENCES buch(buch_id),

    CONSTRAINT fk_angebot_zustand
        FOREIGN KEY (zustand_id)
        REFERENCES zustand(zustand_id),

    CONSTRAINT fk_angebot_standort
        FOREIGN KEY (standort_id)
        REFERENCES standort(standort_id)
);

-- ============================================================
-- 11 - Verfügbarkeit
-- Speichert Zeiträume, in denen ein Angebot für Ausleihe
-- oder Abholung verfügbar ist.
-- ============================================================

CREATE TABLE verfuegbarkeit (
    verfuegbarkeit_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    angebot_id INTEGER NOT NULL,
    beginn TIMESTAMP NOT NULL,
    ende TIMESTAMP NOT NULL,
    verfuegbar BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT ck_verfuegbarkeit_zeitraum
        CHECK (ende > beginn),

    CONSTRAINT fk_verfuegbarkeit_angebot
        FOREIGN KEY (angebot_id)
        REFERENCES angebot(angebot_id)
);

-- ============================================================
-- 12 - Reservierung
-- Speichert Reservierungen von Angeboten durch Benutzer
-- einschließlich Gültigkeitszeitraum und Reservierungsstatus.
-- ============================================================

CREATE TYPE reservierungsstatus AS ENUM (
    'aktiv',
    'storniert',
    'abgelaufen',
    'angenommen'
);

CREATE TABLE reservierung (
    reservierung_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    benutzer_id INTEGER NOT NULL,
    angebot_id INTEGER NOT NULL,
    reservierungsdatum TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gueltig_bis TIMESTAMP NOT NULL,
    status reservierungsstatus NOT NULL DEFAULT 'aktiv',

    CONSTRAINT fk_reservierung_benutzer
        FOREIGN KEY (benutzer_id)
        REFERENCES benutzer(benutzer_id),

    CONSTRAINT fk_reservierung_angebot
        FOREIGN KEY (angebot_id)
        REFERENCES angebot(angebot_id)
);

-- ============================================================
-- TRIGGER - Reservierung nur bei verfügbarem Angebot
-- ============================================================

-- Prüft vor dem Anlegen oder Ändern einer Reservierung,
-- ob das zugehörige Angebot verfügbar ist.

CREATE OR REPLACE FUNCTION pruefe_angebot_verfuegbar()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        SELECT status
        FROM angebot
        WHERE angebot_id = NEW.angebot_id
    ) <> 'verfuegbar' THEN

        RAISE EXCEPTION
            'Das Angebot % ist nicht verfügbar und kann nicht reserviert werden.',
            NEW.angebot_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_reservierung_angebot_verfuegbar
BEFORE INSERT OR UPDATE OF angebot_id
ON reservierung
FOR EACH ROW
EXECUTE FUNCTION pruefe_angebot_verfuegbar();

-- ============================================================
-- 13 - Ausleihe
-- Dokumentiert den vollständigen Ausleihvorgang eines Angebots.
-- Eine Reservierung kann höchstens zu einer Ausleihe führen.
-- ============================================================

CREATE TYPE ausleihstatus AS ENUM (
    'reserviert',
    'aktiv',
    'zurueckgegeben',
    'ueberfaellig',
    'storniert'
);

CREATE TABLE ausleihe (
    ausleihe_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ausleiher_id INTEGER NOT NULL,
    angebot_id INTEGER NOT NULL,
    reservierung_id INTEGER UNIQUE,
    ausleihdatum DATE NOT NULL,
    faelligkeitsdatum DATE NOT NULL,
    rueckgabedatum DATE,
    versand BOOLEAN NOT NULL DEFAULT FALSE,
    status ausleihstatus NOT NULL DEFAULT 'aktiv',

    CONSTRAINT fk_ausleihe_benutzer
        FOREIGN KEY (ausleiher_id)
        REFERENCES benutzer(benutzer_id),

    CONSTRAINT fk_ausleihe_angebot
        FOREIGN KEY (angebot_id)
        REFERENCES angebot(angebot_id),

    CONSTRAINT fk_ausleihe_reservierung
        FOREIGN KEY (reservierung_id)
        REFERENCES reservierung(reservierung_id)
);

-- ============================================================
-- 14 - Bewertung
-- Speichert Bewertungen und Kommentare zu vorhandenen 
-- Ausleihvorgängen. Pro Ausleihe ist höchstens eine Bewertung
-- vorgesehen.
-- ============================================================

CREATE TABLE bewertung (
    bewertung_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ausleihe_id INTEGER NOT NULL UNIQUE,
    sterne INTEGER NOT NULL,
    kommentar TEXT,
    bewertungsdatum TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT ck_bewertung_sterne
        CHECK (sterne BETWEEN 1 AND 5),

    CONSTRAINT fk_bewertung_ausleihe
        FOREIGN KEY (ausleihe_id)
        REFERENCES ausleihe(ausleihe_id)
);

-- ============================================================
-- PERFORMANCE-INDIZES
-- Zusätzliche Indizes für häufig verwendete JOIN-Beziehungen
-- ============================================================

CREATE INDEX idx_angebot_buch_id
ON angebot (buch_id);

CREATE INDEX idx_angebot_anbieter_id
ON angebot (anbieter_id);

CREATE INDEX idx_reservierung_angebot_id
ON reservierung (angebot_id);

CREATE INDEX idx_ausleihe_angebot_id
ON ausleihe (angebot_id);