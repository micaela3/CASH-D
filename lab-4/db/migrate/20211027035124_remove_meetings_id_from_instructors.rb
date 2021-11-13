class RemoveMeetingsIdFromInstructors < ActiveRecord::Migration[6.0]
  def change
    remove_column :instructors, :meetings_id, :integer
    add_column :instructors, :meeting_id, :integer
    add_index :instructors, :meeting_id
  end
end
