class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  def index
    @courses = Course.all.limit(4)
    @latest_courses = Course.all.limit(4).order(created_at: :desc)
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
end
