class Lesson < ApplicationRecord
  belongs_to :course
  validates :title, :content, :course, presence: true

  def to_s
    title
  end

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  # tracked
  tracked owner: Proc.new { |controller, model| controller.current_user }
end
