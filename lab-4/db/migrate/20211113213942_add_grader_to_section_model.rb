class AddGraderToSectionModel < ActiveRecord::Migration[6.0]
  def change
    change_table :sections do |t|
      t.integer :grader_id
    end
  end
end
