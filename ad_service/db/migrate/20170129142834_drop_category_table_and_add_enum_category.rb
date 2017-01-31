class DropCategoryTableAndAddEnumCategory < ActiveRecord::Migration[5.0]
  def change
    drop_table :categories, force: :cascade
    add_column :adverts, :category, :integer, default: 0
  end
end
