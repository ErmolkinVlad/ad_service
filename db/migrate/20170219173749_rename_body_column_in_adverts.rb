class RenameBodyColumnInAdverts < ActiveRecord::Migration[5.0]
  def change
    rename_column :adverts, :body, :description
  end
end
