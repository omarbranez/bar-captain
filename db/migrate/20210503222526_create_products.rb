class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :category
      t.string :subcategory
      t.decimal :quantity
    end
  end
end
