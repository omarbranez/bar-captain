class CreateBars < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.integer :drink_id #it has drinks it can make, based on the products it has
    end
  end
end
