class RemoveProductsDbIdFromUserProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_products, :products_db_id, :integer
  end
end
