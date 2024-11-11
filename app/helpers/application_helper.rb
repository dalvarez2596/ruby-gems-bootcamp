module ApplicationHelper
  include Pagy::Frontend

  def enrollments_count(pending)
    return current_user.enrollments.pending_review.count if pending
    current_user.enrollments.count
  end

  def courses_count
    current_user.courses.count
  end

  def students_count
    Enrollment.joins(:course).where(courses: { user: current_user }).count
  end
end
