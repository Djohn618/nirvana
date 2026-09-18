# Nirvana – Comeback-Tracker

Comeback-Tracker für Disziplin & Produktivität.
Benutzer checken täglich ihre Gewohnheiten ein, verfolgen Streaks
und motivieren sich in Accountability-Gruppen.

## Setup (für Lehrer / neuen PC)

1. Repository klonen:
   git clone https://github.com/DEIN-USERNAME/nirvana.git
   cd nirvana

2. Gems installieren:
   bundle install

3. Datenbank erstellen und Testdaten laden:
   bin/rails db:setup

4. Server starten:
   bin/rails server

5. Browser öffnen: http://localhost:3000

## Test-Login (nach db:seed)

- Admin: admin@nirvana.ch / Admin123
- User: user@nirvana.ch / User123

## Tests ausführen

bin/rails test

## Technologien

- Ruby 4.0.6
- Rails 8.1.3.1
- SQLite3
- Pundit (Autorisierung)
- PaperTrail (Aktivitätsprotokoll)
- bcrypt (Passwort-Hashing)