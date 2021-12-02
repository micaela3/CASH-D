class AddSemesterToGrader < ActiveRecord::Migration[6.0]
  def change
    add_column :graders, :semester, :integer
  end
end
