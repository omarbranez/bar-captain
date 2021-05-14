class RemoveOwnedFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :owned, :boolean
  end
end
