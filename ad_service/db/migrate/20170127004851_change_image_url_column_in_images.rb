class ChangeImageUrlColumnInImages < ActiveRecord::Migration[5.0]
  def up
    rename_column :images, :image_url, :body
  end

  def down
    rename_column :images, :body, :image_url
  end
end
