class MembershipsController < ApplicationController
  before_action :require_login

  def create
    @group = Group.find(params[:group_id])

    ActiveRecord::Base.transaction do
      Membership.create!(user: current_user, group: @group, role: :member)
      # Focus-Habit automatisch anlegen falls nicht vorhanden
      unless current_user.habits.exists?(name: @group.focus_habit_name)
        current_user.habits.create!(name: @group.focus_habit_name)
      end
    end

    redirect_to @group, notice: "You joined '#{@group.name}'! The focus habit '#{@group.focus_habit_name}' was added to your habits."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to @group, alert: "Could not join: #{e.message}"
  end

  def destroy
    @group = Group.find(params[:group_id])
    @membership = @group.memberships.find(params[:id])
    authorize @membership

    user = @membership.user
    group = @group

    ActiveRecord::Base.transaction do
      @membership.destroy!
      habit = user.habits.find_by(name: group.focus_habit_name)
      if habit && habit.habit_logs.count.zero?
        habit.destroy!
      end
    end

    redirect_to @group, notice: "Membership removed."
  end
end