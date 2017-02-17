class ChangeStatusColumnTypeInAdvertsToEnum < ActiveRecord::Migration[5.0]
  def change
    execute 'ALTER TABLE adverts ALTER COLUMN status TYPE integer USING (status::integer);'
  end
end
