class RemoveReferenceOfAdvertAndCategory < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:adverts, :category, index: true)
  end
end
