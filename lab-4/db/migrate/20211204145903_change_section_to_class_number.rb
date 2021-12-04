class ChangeSectionToClassNumber < ActiveRecord::Migration[6.0]
  def change
    remove_column :recommendations, :section, :integer
    add_column :recommendations, :class_number, :integer
  end
end
