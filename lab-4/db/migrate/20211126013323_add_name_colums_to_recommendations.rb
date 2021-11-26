class AddNameColumsToRecommendations < ActiveRecord::Migration[6.0]
  def change
    add_column :recommendations, :grader_name, :string
    add_column :recommendations, :instructor_name, :string
  end
end
