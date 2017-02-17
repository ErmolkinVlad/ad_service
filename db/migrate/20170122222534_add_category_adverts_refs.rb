class AddCategoryAdvertsRefs < ActiveRecord::Migration[5.0]
  def change
    remove_column :adverts, :category, :string
    add_reference :adverts, :category, index: true, foreign_key: true
  end
end
