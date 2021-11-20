class CreateGradersCoursesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :graders, :courses do |t|
      t.index :grader_id
      t.index :course_id
    end
  end
end
