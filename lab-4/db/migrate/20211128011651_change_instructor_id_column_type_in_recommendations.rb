class ChangeInstructorIdColumnTypeInRecommendations < ActiveRecord::Migration[6.0]
  def change
    change_column :recommendations, :instructor_id, :integer
  end
end
