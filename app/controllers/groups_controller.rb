class GroupsController < ApplicationController
  before_action :require_login

  def index
    @my_groups = current_user.groups
    @other_groups = Group.where.not(id: current_user.group_ids)
  end

  def show
    @group = Group.find(params[:id])
    @memberships = @group.memberships.includes(:user)
    @is_member = @group.members.include?(current_user)
    @is_leader = current_user_membership&.role == "leader"

    # Focus-Habit für jedes Member laden
    @focus_habits = {}
    @streaks = {}
    @memberships.each do |m|
      habit = m.user.habits.find_by(name: @group.focus_habit_name)
      @focus_habits[m.user_id] = habit
      @streaks[m.user_id] = habit ? calculate_streak(habit) : 0
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.creator = current_user

    ActiveRecord::Base.transaction do
      @group.save!
      Membership.create!(user: current_user, group: @group, role: :leader)
      # Focus-Habit automatisch für Ersteller anlegen falls nicht vorhanden
      unless current_user.habits.exists?(name: @group.focus_habit_name)
        current_user.habits.create!(name: @group.focus_habit_name)
      end
    end

    redirect_to @group, notice: "Group '#{@group.name}' created!"
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  def destroy
    @group = Group.find(params[:id])
    authorize @group
    @group.destroy
    redirect_to groups_path, notice: "Group deleted."
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :focus_habit_name)
  end

  def current_user_membership
    @group.memberships.find_by(user: current_user)
  end

  def calculate_streak(habit)
    streak = 0
    date = Date.today

    loop do
      log = habit.habit_logs.find_by(date: date, completed: true)
      break unless log
      streak += 1
      date -= 1.day
    end

    streak
  end
end