class RenameProductsToUserProducts < ActiveRecord::Migration[6.1]
  def change
    rename_table :products, :user_products
  end
end
