# Nirvana – Comeback-Tracker für Disziplin

Multi-User-Applikation (Modul 223) – Ruby on Rails.

## Voraussetzungen

- Ruby 4.0.6
- Rails 8.1.3.1
- Bundler 2.5.x
- SQLite 3

## Installation

### 1. ZIP entpacken und in Ordner wechseln

```bash
cd nirvana-main
```

### 2. Berechtigungen für bin/-Skripte setzen

**Wichtig:** Beim Entpacken der ZIP-Datei gehen unter Linux/Mac die
Ausführungs-Berechtigungen verloren. Deswegen zuerst:

```bash
chmod +x bin/*
```

### 3. Dependencies installieren

```bash
bundle install
```

### 4. Datenbank aufsetzen

```bash
bin/rails db:setup
```

Erstellt die SQLite-Datenbank, führt Migrations aus und lädt Test-Daten.

### 5. Server starten

```bash
bin/rails server
```

App läuft auf: http://localhost:3000

## Test-Logins

| Rolle  | Email               | Passwort        |
|--------|---------------------|-----------------|
| Admin  | admin@nirvana.ch    | Admin12345678   |
| Member | user@nirvana.ch     | User12345678    |
| Member | sarah@nirvana.ch    | Sarah12345678   |

## Tests ausführen

```bash
bin/rails test
```

Sollte 17 grüne Tests zeigen.

## Vollständige Dokumentation

Siehe `docs/dokumentation.md` bzw. `docs/Projektdokumentation_Nirvana.docx`

## Referenz

Public GitHub Repo: https://github.com/Djohn618/nirvana