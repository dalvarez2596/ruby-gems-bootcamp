class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  allow_browser versions: :modern

  before_action :set_global_variables, if: :user_signed_in?
  # navbar search
  def set_global_variables
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
  end
end
