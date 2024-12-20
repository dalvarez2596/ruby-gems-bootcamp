class Enrollment < ApplicationRecord
  belongs_to :course, counter_cache:  true
  # Course.find_each{ |course| Course.reset_counters(course.id, :enrollments)}
  belongs_to :user, counter_cache: true
  # User.find_each{ |user| User.reset_counters(user.id, :enrollments)}

  validates :user, :course, presence: true
  # User cant be subscribed to the same course twice

  validates_presence_of :rating, if: :review?
  validates_presence_of :review, if: :rating?

  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id

  validate :cant_subscribe_to_own_course

  scope :pending_review, -> { where(rating: [ 0, nil, "" ], review: [ 0, nil, "" ]) }
  scope :reviewed, -> { where.not(rating: [ 0, nil, "" ]) }
  scope :latest_good_reviews, -> { limit(4).order(rating: :desc, created_at: :desc) }

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def self.ransackable_associations(auth_object = nil)
    [ "course", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "price", "review", "rating", "updated_at", "created_at" ]
  end

  def to_s
    user.to_s + " " + course.to_s
  end

  after_save do
    course.update_rating unless rating.nil? || rating.zero?
  end

  after_destroy do
    course.update_rating
  end

  protected
  def cant_subscribe_to_own_course
    if self.new_record?
      if self.user_id.present?
        if self.user_id == course.user_id
          errors.add(:base, "You can not subscribe to your own course")
        end
      end
    end
  end
end
