class CreateHabitLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :habit_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :habit, null: false, foreign_key: true
      t.date :date
      t.boolean :completed
      t.index [:user_id, :habit_id, :date], unique: true
      
      t.timestamps
    end
  end
end
