class RemoveColumnsFromSection < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :time, :string
    remove_column :sections, :day, :string
    remove_column :sections, :location, :string
  end
end
