class RenameProductsDbsToProducts < ActiveRecord::Migration[6.1]
  def change
    rename_table :products_dbs, :products
  end
end
