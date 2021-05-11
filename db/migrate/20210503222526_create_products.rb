class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :category # vodka, grenadine, soda
      t.string :subcategory # sub category
      t.text :description
      t.boolean :owned
    end
  end
end
