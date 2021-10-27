class AddCourseToSection < ActiveRecord::Migration[6.0]
  def change
    add_reference :sections, :course, index: true
  end
end
