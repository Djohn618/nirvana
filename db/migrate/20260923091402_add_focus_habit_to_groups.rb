class AddFocusHabitToGroups < ActiveRecord::Migration[8.1]
  def change
    add_column :groups, :focus_habit_name, :string, null: false, default: "Focus Habit"
  end
end
