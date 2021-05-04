class CreateMenuDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_drinks do |t|
      t.integer :menu_id 
      t.integer :drink_id 
    end
  end
end
