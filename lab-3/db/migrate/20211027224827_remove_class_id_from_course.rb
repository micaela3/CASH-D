class RemoveClassIdFromCourse < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :course_id, :integer
    add_column :courses, :course_number, :string
    remove_column :meetings, :section_number, :integer
    add_reference :meetings, :sections
  end
end
