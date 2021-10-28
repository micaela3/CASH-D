class AddCourseIdBackToSections < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :courses
    add_reference :sections, :course
  end
end
