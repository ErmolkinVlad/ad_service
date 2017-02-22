class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.references :user, foreign_key: true, null: false
      t.datetime :time, null: false
      t.string :prev_status, default: 'recent'
      t.string :new_status, null: false
      t.text :comment
      t.references :advert, foreign_key: true

      t.timestamps
    end
  end
end
