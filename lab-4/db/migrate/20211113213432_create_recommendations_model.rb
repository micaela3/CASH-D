class CreateRecommendationsModel < ActiveRecord::Migration[6.0]
  def change
    create_table :recommendations do |t|
      t.integer :grader_id
      t.integer :instructor_id
      t.string :course
      t.string :section
      t.string :comments
    end
  end
end
