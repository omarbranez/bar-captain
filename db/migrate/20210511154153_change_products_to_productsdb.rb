class ChangeProductsToProductsdb < ActiveRecord::Migration[6.1]
  def change
    rename_table :products, :products_db
  end
end
