# Nirvana – Comeback Tracker

A comeback tracker for discipline & productivity.
Users create their own habits, check in daily, track streaks,
and motivate each other in accountability groups.

## Setup (for teacher / new PC)

1. Clone repository:
   git clone https://github.com/Djohn618/nirvana.git
   cd nirvana

2. Install gems:
   bundle install

3. Create database and load test data:
   bin/rails db:setup

4. Start server:
   bin/rails server

5. Open browser: http://localhost:3000

## Test login (after db:seed)

- Admin: admin@nirvana.ch / Admin12345678
- User: user@nirvana.ch / User12345678

## Run tests

bin/rails test

## Tech stack

- Ruby 4.0.6
- Rails 8.1.3.1
- SQLite3
- Pundit (authorization)
- PaperTrail (activity log)
- bcrypt (password hashing)