class RemoveSectionIdFromMeetings < ActiveRecord::Migration[6.0]
  def change
    remove_column :meetings, :section_id, :integer
    add_column :meetings, :section_number, :integer
    add_index :meetings, :section_number
  end
end
