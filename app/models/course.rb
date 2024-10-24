class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { minimum: 5 }

  belongs_to :user
  def to_s
    title
  end

  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "short_description", "language", "level", "price" ]
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
  # tracked
  tracked owner: Proc.new { |controller, model| controller.current_user }
end
