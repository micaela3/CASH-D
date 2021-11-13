class RemoveCoursesIdFromSection < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :courses_id, :integer
    remove_column :meetings, :sections_id, :intger
  end
end
