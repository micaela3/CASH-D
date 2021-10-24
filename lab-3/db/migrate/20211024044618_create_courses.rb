class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_description
      t.string :course_title
      t.integer :course_id

      t.timestamps
    end
  end
end
