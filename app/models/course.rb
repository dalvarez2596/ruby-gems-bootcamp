class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  validates :title, uniqueness: true
  belongs_to :user, counter_cache: true
  # User.find_each{ |user| User.reset_counters(user.id, :courses)}

  has_one_attached :avatar
  validates :avatar, attached: true, content_type: [ "image/png", "image/jpeg", "image/jpg" ], size: { less_than: 500.kilobytes, message: "size should be under 500 kilobytes" }


  scope :latest, -> { limit(4).order(created_at: :desc) }
  scope :top_rated, -> { limit(4).order(average_rating: :desc, created_at: :desc) }
  scope :popular, -> { limit(4).order(enrollments_count: :desc, created_at: :desc) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> {where(published: false) }
  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :restrict_with_error
  has_many :user_lessons, through: :lessons

  def to_s
    title
  end

  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "short_description", "language", "level", "price", "average_rating", "created_at", "enrollments_count" ]
  end
  def self.ransackable_associations(auth_object = nil)
    [ "rich_text_description", "user" ]
  end

  # Use this instead of normal name for transactions, is secure
  # friendly_id :generated_slug, use: :slugged

  # def generated_slug
  #   require 'securerandom'
  #   @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
  # end

  # def to_s
  #   slug
  # end
  LANGUAGES = [ :"English", :"Spanish", :"Japanese" ]
  def self.languages
    LANGUAGES.map { |language| [ language, language ] }
  end

  LEVELS = [ :"Beginner", :"Intermediate", :"Advanced" ]
  def self.levels
    LEVELS.map { |level| [ level, level ] }
  end

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }
  # tracked

  def bought(user)
    self.enrollments.where(user_id: [ user.id ], course_id: [ self.id ]).any?
  end

  def progress(user)
    unless self.lessons.count.zero?
      user_lessons.where(user: user).count / self.lessons_count.to_f * 100
    end
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end
end
