class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_paper_trail_whodunnit

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user.present?
  end
  helper_method :logged_in?

  def require_login
    unless logged_in?
      redirect_to new_session_path, alert: "Please log in first."
    end
  end

  private

  def user_for_paper_trail
    current_user&.id
  end
end