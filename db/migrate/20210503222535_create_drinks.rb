class CreateDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :ingredient1
      t.decimal :ing_quantity1
      t.string :ingredient2
      t.decimal :ing_quantity2
      t.string :ingredient3
      t.decimal :ing_quantity3
      t.string :ingredient4
      t.decimal :ing_quantity4
      t.string :ingredient5
      t.decimal :ing_quantity5
      t.string :ingredient6
      t.decimal :ing_quantity6
      t.text :recipe
      t.text :image_link
    end
  end
end
