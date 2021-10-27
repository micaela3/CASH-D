class RemoveCourseIdFromSectionsAgain < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :course_id, :integer
    add_reference :sections, :courses
  end
end
