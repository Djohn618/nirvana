class ProfilesController < ApplicationController
  before_action :require_login, except: [:confirm]

  def show
  end

  def edit
  end

def update
  # 1. Passwort-Änderung (falls angefordert)
  if profile_params[:password].present?
    unless current_user.authenticate(profile_params[:current_password])
      current_user.errors.add(:current_password, "is incorrect")
      render :edit, status: :unprocessable_entity
      return
    end

    unless current_user.update(password: profile_params[:password],
                                password_confirmation: profile_params[:password_confirmation])
      render :edit, status: :unprocessable_entity
      return
    end
  end

  # 2. E-Mail-Änderung (falls angefordert)
  if profile_params[:email] != current_user.email && profile_params[:email].present?
    new_email = profile_params[:email]

    # Check ob Email im richtigen Format ist
    unless new_email =~ URI::MailTo::EMAIL_REGEXP
      current_user.errors.add(:email, "is not a valid email address")
      render :edit, status: :unprocessable_entity
      return
    end

    # Check ob Email schon von jemand anderem benutzt wird
    if User.where.not(id: current_user.id).exists?(email: new_email.downcase)
      current_user.errors.add(:email, "is already taken")
      render :edit, status: :unprocessable_entity
      return
    end

    token = SecureRandom.urlsafe_base64

    ActiveRecord::Base.transaction do
      current_user.update!(unconfirmed_email: new_email, confirmation_token: token)
      Rails.logger.info "Email confirmation link for #{new_email}: #{confirm_profile_url(token: token)}"
    end
  end

  # 3. Username-Änderung
  if profile_params[:username].present? && profile_params[:username] != current_user.username
    current_user.update(username: profile_params[:username])
  end

  # 4. Erfolgsmeldung passend zusammensetzen
  messages = []
  messages << "Password updated" if profile_params[:password].present?
  messages << "Confirmation link for '#{profile_params[:email]}' logged to console" if profile_params[:email] != current_user.email && profile_params[:email].present?
  messages << "Profile updated" if messages.empty?

  redirect_to profile_path, notice: messages.join(". ") + "."
end

  def confirm
  user = User.find_by(confirmation_token: params[:token])

  if user && user.unconfirmed_email.present?
    if user.update(email: user.unconfirmed_email, unconfirmed_email: nil, confirmation_token: nil)
      redirect_to profile_path, notice: "Email successfully changed."
    else
      redirect_to root_path, alert: "Email could not be confirmed."
    end
  else
    redirect_to root_path, alert: "Invalid or expired confirmation link."
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