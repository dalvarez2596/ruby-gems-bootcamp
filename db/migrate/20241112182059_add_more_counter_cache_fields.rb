class AddMoreCounterCacheFields < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :lessons_count, :integer, null: false, default: 0
    add_column :users, :courses_count, :integer, null: false, default: 0 
    add_column :users, :enrollments_count, :integer, null:false, default: 0
  end
end
