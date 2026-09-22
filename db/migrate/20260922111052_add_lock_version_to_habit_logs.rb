class AddLockVersionToHabitLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :habit_logs, :lock_version, :integer, default: 0, null: false
  end
end
