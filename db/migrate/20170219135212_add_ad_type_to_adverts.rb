class AddAdTypeToAdverts < ActiveRecord::Migration[5.0]
  def change
    add_column :adverts, :ad_type, :integer, default: 0
  end
end
