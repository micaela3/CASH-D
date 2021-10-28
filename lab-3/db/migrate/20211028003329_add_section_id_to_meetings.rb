class AddSectionIdToMeetings < ActiveRecord::Migration[6.0]
  def change
    remove_column :meetings, :sections
    add_reference :meetings, :section
  end
end
