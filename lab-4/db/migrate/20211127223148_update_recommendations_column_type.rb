class UpdateRecommendationsColumnType < ActiveRecord::Migration[6.0]
  def change
    change_table :recommendations do |t|
      t.change :section, :integer
    end
  end
end
