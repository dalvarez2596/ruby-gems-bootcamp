class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_course, only: %i[ show edit update destroy approve unapprove analytics ]

  # GET /courses or /courses.json
  def index
    # This was using the ILIKE in the first search header that we made, now with
    # ransack we dont need it
    # if params[:title]
    #   @courses = Course.where("title ILIKE ?",
    #     Course.sanitize_sql_like(params[:title]) + "%")
    # else
    #   # @courses = Course.all
    #   # for advance and the header search we remove this q and use ransack courses
    #   # @q = Course.ransack(params[:q])
    # end
    # rolify example:

    # if current_user.has_role?(:admin)
    #   @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
    #   @courses = @ransack_courses.result.includes(:user)
    # else
    #   redirect_to root_path, alert: "You don have access"
    # end

    @ransack_path = courses_path
    @ransack_courses = Course.published.approved.ransack(params[:courses_search], search_key: :courses_search)
    # @courses = @ransack_courses.result.includes(:user)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
  end

  # GET /courses/1 or /courses/1.json
  def show
    authorize @course
    @lessons = @course.lessons.rank(:row_order)
    @enrollments_with_review = @course.enrollments.reviewed
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  # GET /courses/1/edit
  def edit
    authorize @course
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    authorize @course
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    authorize @course, :approve?
    @course.update_attribute(:approved, true)
    redirect_to @course, notice: "Course approved and visible!"
  end

  def unapprove
    authorize @course, :approve?
    @course.update_attribute(:approved, false)
    redirect_to @course, notice: "Course unapproved and hidden!"
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def purchased
    @ransack_path = purchased_courses_path
    @ransack_courses = Course.joins(:enrollments).where(enrollments: { user: current_user }).ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
    render "index"
  end

  def pending_review
    @ransack_path = pending_review_courses_path
    @ransack_courses = Course.joins(:enrollments).merge(Enrollment.pending_review.where(user: current_user)).ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
    render "index"
  end

  def created
    @ransack_path = created_courses_path
    @ransack_courses = Course.where(user: current_user).ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
    render "index"
  end

  def unapproved
    @ransack_path = unapproved_courses_path
    @ransack_courses = Course.unapproved.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
    render "index"
  end

  def analytics
    authorize @course, :owner?
  end

  def destroy
    authorize @course
    if @course.destroy
      respond_to do |format|
        format.html { redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to @course, alert: "Course has enrollments. Can not be destroyed."
    end
  end

  private
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :short_description, :price, :published, :language, :level, :avatar)
    end
end
