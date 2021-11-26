class RenameCoursesGraders < ActiveRecord::Migration[6.0]
  def change
    rename_table :courses_graders, :coursesGraders
  end
end
