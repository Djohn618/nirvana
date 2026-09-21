class HabitsController < ApplicationController
  before_action :require_login

  def index
    @habits = current_user.habits
    @streaks = {}
    @habits.each do |habit|
      @streaks[habit.id] = calculate_streak(habit)
    end
  end

  def new
    @habit = current_user.habits.build
  end

  def create
    @habit = current_user.habits.build(habit_params)

    if @habit.save
      redirect_to habits_path, notice: "Habit '#{@habit.name}' created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @habit = current_user.habits.find(params[:id])
    @habit.destroy
    redirect_to habits_path, notice: "Habit deleted."
  end

  private

  def habit_params
    params.require(:habit).permit(:name)
  end

  def calculate_streak(habit)
    streak = 0
    date = Date.today

    loop do
      log = habit.habit_logs.find_by(user: current_user, date: date, completed: true)
      break unless log
      streak += 1
      date -= 1.day
    end

    streak
  end
end