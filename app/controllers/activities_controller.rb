class ActivitiesController < ApplicationController
  before_action :require_login

  def index
    @versions = PaperTrail::Version.order(created_at: :desc).limit(50)
  end
end