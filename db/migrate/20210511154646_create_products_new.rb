class CreateProductsNew < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :products_db_id
    end
  end
end
