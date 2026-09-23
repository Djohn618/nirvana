puts "Creating test data..."

# Admin-User erstellen
admin = User.create!(
  username: "Admin",
  email: "admin@nirvana.ch",
  password: "Admin12345678",
  password_confirmation: "Admin12345678",
  role: :admin
)

# Normaler User erstellen
user1 = User.create!(
  username: "John",
  email: "user@nirvana.ch",
  password: "User12345678",
  password_confirmation: "User12345678",
  role: :member
)

user2 = User.create!(
  username: "Sarah",
  email: "sarah@nirvana.ch",
  password: "Sarah12345678",
  password_confirmation: "Sarah12345678",
  role: :member
)

# Gewohnheiten für User 1
workout = Habit.create!(user: user1, name: "Workout")
meditation = Habit.create!(user: user1, name: "Meditation")
study = Habit.create!(user: user1, name: "Study")
wake_early = Habit.create!(user: user1, name: "Wake up early")

# Gewohnheiten für User 2
Habit.create!(user: user2, name: "Running")
Habit.create!(user: user2, name: "Reading")
Habit.create!(user: user2, name: "Meditation")

# HabitLogs für die letzten 7 Tage (User 1)
[workout, meditation, study, wake_early].each do |habit|
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
  description: "We rise early every day and stick to our routine.",
  focus_habit_name: "Wake up early",
  creator: user1
)

# Memberships erstellen
Membership.create!(user: user1, group: group, role: :leader)
Membership.create!(user: user2, group: group, role: :member)

puts "Done! #{User.count} users, #{Habit.count} habits, #{HabitLog.count} logs, #{Group.count} groups created."