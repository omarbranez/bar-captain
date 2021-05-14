class AddDrinksIdToUserDrinks < ActiveRecord::Migration[6.1]
  def change
    add_column :user_drinks, :drinks_id, :integer
  end
end
