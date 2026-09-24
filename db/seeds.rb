puts "Creating test data..."

# ============================================
# USERS
# ============================================
admin = User.create!(
  username: "Admin",
  email: "admin@nirvana.ch",
  password: "Admin12345678",
  password_confirmation: "Admin12345678",
  role: :admin
)

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

# ============================================
# HABITS für John (user1)
# "Wake up before 6 AM" muss zum Focus-Habit der Early Birds passen
# ============================================
workout    = Habit.create!(user: user1, name: "Workout")
meditation = Habit.create!(user: user1, name: "Meditation")
study      = Habit.create!(user: user1, name: "Study")
wake_early = Habit.create!(user: user1, name: "Wake up before 6 AM")

# ============================================
# HABITS für Sarah (user2)
# BEWUSST: Sarah hat NICHT den Focus-Habit "Wake up before 6 AM"
# Der wird ihr automatisch angelegt wenn sie in der Demo beitritt!
# ============================================
Habit.create!(user: user2, name: "Running")
Habit.create!(user: user2, name: "Reading")
Habit.create!(user: user2, name: "Meditation")

# ============================================
# HABIT LOGS für die letzten 7 Tage (John)
# Zeigt schöne Streaks für die Demo
# ============================================
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

# ============================================
# GRUPPE "Early Birds"
# John ist Leader, Sarah tritt in der Demo live bei
# ============================================
early_birds = Group.create!(
  name: "Early Birds",
  description: "We rise before 6 AM every day and start with discipline.",
  focus_habit_name: "Wake up before 6 AM",
  creator: user1
)

# NUR John als Leader in der Gruppe
# Sarah wird in der Demo live beitreten - dann wird ihr automatisch
# der Habit "Wake up before 6 AM" angelegt
Membership.create!(user: user1, group: early_birds, role: :leader)

puts "Done! #{User.count} users, #{Habit.count} habits, #{HabitLog.count} logs, #{Group.count} groups created."
puts ""
puts "Test-Logins:"
puts "  Admin:  admin@nirvana.ch  / Admin12345678"
puts "  John:   user@nirvana.ch   / User12345678   (Leader of Early Birds, 7-day streaks)"
puts "  Sarah:  sarah@nirvana.ch  / Sarah12345678  (Not in any group - joins during demo)"