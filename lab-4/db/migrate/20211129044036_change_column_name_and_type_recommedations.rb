class ChangeColumnNameAndTypeRecommedations < ActiveRecord::Migration[6.0]
  def change
    remove_column :recommendations, :course, :string
    add_column :recommendations, :course_id, :integer
  end
end
