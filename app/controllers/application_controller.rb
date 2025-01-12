class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery

  after_action :user_activity, if: :user_signed_in?
  allow_browser versions: :modern

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include PublicActivity::StoreController # save current_user using gem public activity

  include Pagy::Backend

  before_action :set_global_variables, if: :user_signed_in?
  # navbar search
  def set_global_variables
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
  end

  private

  def user_activity
    current_user.try :touch
  end

  def user_not_authorized # pundit
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end
end
