class Admin::UsersController < ApplicationController
  before_action :require_login

  def index
    authorize User
    @users = User.all.order(:username)
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(admin_user_params)
      redirect_to admin_users_path, notice: "User '#{@user.username}' updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user

    @user.destroy
    redirect_to admin_users_path, notice: "User deleted."
  end

  private

  def admin_user_params
    params.require(:user).permit(:username, :email, :role)
  end
end