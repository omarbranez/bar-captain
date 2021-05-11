class CreateDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :drink_type
      t.string :glass_type
      t.string :ingredient1
      t.string :quantity1
      t.string :ingredient2
      t.string :quantity2
      t.string :ingredient3
      t.string :quantity3
      t.string :ingredient4
      t.string :quantity4
      t.string :ingredient5
      t.string :quantity5
      t.string :ingredient6
      t.string :quantity6
      t.string :ingredient7
      t.string :quantity7
      t.string :ingredient8
      t.string :quantity8
      t.text :instructions
      t.string :photo_url
      t.boolean :makeable
    end
  end
end
