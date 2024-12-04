class AddImpressionToUserLessons < ActiveRecord::Migration[7.2]
  def change
    add_column :user_lessons, :impression, :integer, default: 0, null: false
  end
end
