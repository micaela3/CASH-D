class ChangeColumnTypeOnRecommendationsTable < ActiveRecord::Migration[6.0]
  def change
    change_column :recommendations, :instructor_id, :string
    change_column :recommendations, :grader_id, :string
  end
end
