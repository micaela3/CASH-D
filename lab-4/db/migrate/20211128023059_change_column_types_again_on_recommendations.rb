class ChangeColumnTypesAgainOnRecommendations < ActiveRecord::Migration[6.0]
  def change
    remove_column :recommendations, :instructor_id, :integer
    add_column :recommendations, :user_id, :integer
    change_column :recommendations, :grader_id, :integer
  end
end
