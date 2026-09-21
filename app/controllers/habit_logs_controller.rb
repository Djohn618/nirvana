class HabitLogsController < ApplicationController
  before_action :require_login

  def new
    @habits = current_user.habits
    @today_logs = current_user.habit_logs.where(date: Date.today)
  end

  def create
    habit = current_user.habits.find(params[:habit_id])
    date = Date.today

    existing_log = current_user.habit_logs.find_by(habit: habit, date: date)

    if existing_log
      existing_log.update!(completed: !existing_log.completed)
    else
      HabitLog.create!(user: current_user, habit: habit, date: date, completed: true)
    end

    redirect_to new_habit_log_path, notice: "#{habit.name} updated!"
  end
end