class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.integer :section_number
      t.integer :class_number
      t.string :time
      t.string :day
      t.string :location
      t.string :component
      t.date :start_date
      t.date :end_date
      t.integer :course_id

      t.timestamps
    end
  end
end
