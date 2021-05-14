class RenameDrinksToUserDrinks < ActiveRecord::Migration[6.1]
  def change
    rename_table :drinks, :user_drinks
  end
end
