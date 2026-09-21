class GroupsController < ApplicationController
  before_action :require_login

  def index
    @my_groups = current_user.groups
    @other_groups = Group.where.not(id: @my_groups.pluck(:id))
  end

  def show
    @group = Group.find(params[:id])
    @memberships = @group.memberships.includes(:user)
    @is_member = @group.memberships.exists?(user: current_user)
    @is_leader = @group.creator == current_user ||
                 @group.memberships.exists?(user: current_user, role: :leader)

    member_ids = @group.members.pluck(:id)
    @member_stats = {}
    member_ids.each do |mid|
      user = User.find(mid)
      total = user.habits.count
      done = user.habit_logs.where(date: Date.today, completed: true).count
      @member_stats[mid] = { total: total, done: done }
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.creator = current_user

    if @group.save
      Membership.create!(user: current_user, group: @group, role: :leader)
      redirect_to @group, notice: "Group '#{@group.name}' created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @group = Group.find(params[:id])
    authorize @group

    @group.destroy
    redirect_to groups_path, notice: "Group deleted."
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end