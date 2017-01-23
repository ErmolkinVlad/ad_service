class CreateAdverts < ActiveRecord::Migration[5.0]
  def change
    create_table :adverts do |t|
      t.string :title
      t.text :body
      t.float :price
      t.string :category
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
