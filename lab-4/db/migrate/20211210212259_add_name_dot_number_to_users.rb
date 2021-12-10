class AddNameDotNumberToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name_dot_number, :string
    add_index :users, :name_dot_number
  end
end
