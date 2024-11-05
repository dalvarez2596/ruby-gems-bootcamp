class AddSlugToEnrollments < ActiveRecord::Migration[7.2]
  def change
    add_column :enrollments, :slug, :string
    add_index :enrollments, :slug, unique: true
  end
end
