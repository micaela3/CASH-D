class RemoveGraderIdFromSections < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :grader_id, :integer
  end
end
