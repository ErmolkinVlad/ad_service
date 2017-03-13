class ChangeNameOfCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :title, :name
  end
end
