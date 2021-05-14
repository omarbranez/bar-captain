class AddProductIdToUserProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :user_products, :product_id, :integer
  end
end
