class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validates :user, :lesson, presence: true

  validates_uniqueness_of :user_id, scope: :lesson_id
  validates_uniqueness_of :lesson_id, scope: :user_id

  def increase_impression
    UserLesson.increment_counter(:impression, self.id)
  end
end
