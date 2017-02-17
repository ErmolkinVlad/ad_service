class AddDefaultValueForStatusInAdverts < ActiveRecord::Migration[5.0]
  def up
    change_column_default(:adverts, :status, 0)
  end
end
