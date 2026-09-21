class ProfilesController < ApplicationController
  before_action :require_login

  def show
  end

  def edit
  end

  def update
    if profile_params[:password].present?
      unless current_user.authenticate(profile_params[:current_password])
        current_user.errors.add(:current_password, "is incorrect")
        render :edit, status: :unprocessable_entity
        return
      end
    end

    if profile_params[:email] != current_user.email && profile_params[:email].present?
      new_email = profile_params[:email]
      token = SecureRandom.urlsafe_base64

      ActiveRecord::Base.transaction do
        current_user.update!(unconfirmed_email: new_email, confirmation_token: token)
        confirmation_link = "http://localhost:3000/profile/confirm?token=#{token}"
        Rails.logger.debug "=== EMAIL CONFIRMATION LINK ==="
        Rails.logger.debug confirmation_link
        Rails.logger.debug "==============================="
      end

      redirect_to profile_path, notice: "Confirmation link has been logged to the console."
      return
    end

    if current_user.update(profile_update_params)
      redirect_to profile_path, notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end

  def profile_update_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end