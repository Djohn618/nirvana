class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticate_by protects against timing attacks
    user = User.authenticate_by(
      email: params[:email],
      password: params[:password]
    )

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back, #{user.username}!"
    else
      flash.now[:alert] = "Email or password is incorrect."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "You've been logged out."
  end
end