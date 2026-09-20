puts "Erstelle Testdaten..."

# Admin-User erstellen
admin = User.create!(
  username: "Admin",
  email: "admin@nirvana.ch",
  password: "Admin123",
  password_confirmation: "Admin123",
  role: :admin
)

# Normaler User erstellen
user1 = User.create!(
  username: "John",
  email: "user@nirvana.ch",
  password: "User123",
  password_confirmation: "User123",
  role: :member
)

user2 = User.create!(
  username: "Maria",
  email: "sarah@nirvana.ch",
  password: "Sarah123",
  password_confirmation: "Sarah123",
  role: :member
)

# Gewohnheiten für User 1
sport = Habit.create!(user: user1, name: "Sport")
meditation = Habit.create!(user: user1, name: "Meditation")
lernen = Habit.create!(user: user1, name: "Lernen")
aufstehen = Habit.create!(user: user1, name: "Früh aufstehen")

# Gewohnheiten für User 2
Habit.create!(user: user2, name: "Joggen")
Habit.create!(user: user2, name: "Lesen")
Habit.create!(user: user2, name: "Meditation")

# HabitLogs für die letzten 7 Tage (User 1)
[sport, meditation, lernen, aufstehen].each do |habit|
  7.times do |i|
    HabitLog.create!(
      user: user1,
      habit: habit,
      date: Date.today - i,
      completed: [true, true, true, false, true, true, true][i]
    )
  end
end

# Gruppe erstellen
group = Group.create!(
  name: "Morning Crew",
  description: "Wir stehen jeden Tag früh auf und ziehen unser Programm durch.",
  creator: user1
)

# Memberships erstellen
Membership.create!(user: user1, group: group, role: :leader)
Membership.create!(user: user2, group: group, role: :member)

puts "Fertig! #{User.count} User, #{Habit.count} Gewohnheiten, #{HabitLog.count} Logs, #{Group.count} Gruppen erstellt."