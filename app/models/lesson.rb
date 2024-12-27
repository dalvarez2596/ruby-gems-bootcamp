class Lesson < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :course_id

  belongs_to :course, counter_cache: true
  has_many :user_lessons, dependent: :destroy
  # Course.find_each{ |course| Course.reset_counters(course.id, :lessons)}
  validates :title, :content, :course, presence: true

  has_rich_text :content

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }
  # tracked

  def to_s
    title
  end

  def previous_lesson
    course.lessons.where("row_order < ?", row_order).last
  end

  def next_lesson
    course.lessons.where("row_order > ?", row_order).last
  end

  def viewed?(user)
    self.user_lessons.where(user: user).present?
    # self.user_lessons.where(user_id: [user.id], lesson_id: [self.id]).empty?
  end
end
