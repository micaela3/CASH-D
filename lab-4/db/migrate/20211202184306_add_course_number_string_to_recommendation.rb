class AddCourseNumberStringToRecommendation < ActiveRecord::Migration[6.0]
  def change
    remove_column :recommendations, :course_id
    add_column :recommendations, :course_number, :string
  end
end
