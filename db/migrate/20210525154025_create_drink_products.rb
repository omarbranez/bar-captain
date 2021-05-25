class CreateDrinkProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :drink_products do |t|
      t.integer :drink_id
      t.integer :product_id
      t.string :quantity
    end
  end
end
