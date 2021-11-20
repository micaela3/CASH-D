class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.references :grader, null: false, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.integer :weekday

      t.timestamps
    end
  end
end
