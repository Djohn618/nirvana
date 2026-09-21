class MembershipsController < ApplicationController
  before_action :require_login

  def create
    @group = Group.find(params[:group_id])

    if @group.memberships.exists?(user: current_user)
      redirect_to @group, alert: "You're already a member."
      return
    end

    Membership.create!(user: current_user, group: @group, role: :member)
    redirect_to @group, notice: "You joined the group!"
  end

  def destroy
    @group = Group.find(params[:group_id])
    @membership = @group.memberships.find(params[:id])

    is_leader = @group.creator == current_user ||
                @group.memberships.exists?(user: current_user, role: :leader)

    if @membership.user == current_user || is_leader || current_user.admin?
      @membership.destroy
      redirect_to @group, notice: "Membership ended."
    else
      redirect_to @group, alert: "Not authorized."
    end
  end
end