class AddNameNumberToGradersModel < ActiveRecord::Migration[6.0]
  def change
    add_column :graders, :name_dot_number, :string
    remove_column :recommendations, :grader_id, :integer
    add_column :recommendations, :grader_name_dot_number, :string
  end
end
