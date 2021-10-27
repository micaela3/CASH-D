class CreateInstructors < ActiveRecord::Migration[6.0]
  def change
    create_table :instructors do |t|
      t.string :instructor_name
      t.string :instructor_email
      t.references :meetings, null: false, foreign_key: true

      t.timestamps
    end
  end
end
