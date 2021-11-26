class AddCascadingDeleteToForeignKeys < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key "availabilities", "graders"
    remove_foreign_key "graders", "sections"
    remove_foreign_key "graders", "users"
    add_foreign_key "availabilities", "graders", on_delete: :cascade
    add_foreign_key "graders", "sections", on_delete: :cascade
    add_foreign_key "graders", "users", on_delete: :cascade
  end
end
