class AddHasGraderToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :has_grader, :boolean, default: false
  end
end
