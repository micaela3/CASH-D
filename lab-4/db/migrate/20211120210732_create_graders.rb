class CreateGraders < ActiveRecord::Migration[6.0]
  def change
    create_table :graders do |t|
      t.string :name
      t.string :email
      t.string :major
      t.references :user, null: false, foreign_key: true
      t.boolean :assigned
      t.references :section, null: true, foreign_key: true

      t.timestamps
    end
  end
end
