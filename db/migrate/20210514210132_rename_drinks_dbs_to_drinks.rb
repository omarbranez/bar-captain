class RenameDrinksDbsToDrinks < ActiveRecord::Migration[6.1]
  def change
    rename_table :drinks_dbs, :drinks
  end
end
