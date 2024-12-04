class User < ApplicationRecord
  rolify

  extend FriendlyId
  friendly_id :email, use: :slugged

  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "email", "sign_in_count" ]
  end

  # to not delete all user dependencies when user got deleted or
  # destroy his own account we add nullify
  # anyways this delete cant be perform
  # cause user_id null false validation is in schema
  # so need another migration to set remove
  # :user_id, null:false
  has_many :courses, dependent: :nullify
  has_many :enrollments, dependent: :nullify
  has_many :user_lessons, dependent: :nullify

  # this is more basic
  # def assign_default_role
  #   self.add_role(:student) if self.roles.blank?
  # end

  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:student)
    else
      self.add_role(:student) if self.roles.blank?
      self.add_role(:teacher)  # to allow any user to create own courses
    end
  end

  def online?
    updated_at > 2.minutes.ago
  end

  def buy_course(course)
    self.enrollments.create(course: course, price: course.price)
  end

  def view_lesson(lesson)
    user_lesson = self.user_lessons.where(lesson: lesson)
    unless user_lesson.any?
      self.user_lessons.create(lesson: lesson)
    else
      user_lesson.first.increase_impression
    end
  end

  private
  validate :must_have_a_role, on: :update
  def must_have_a_role
    errors.add(:role_ids, "Must have a at least one role.") unless roles.any?
  end
end
