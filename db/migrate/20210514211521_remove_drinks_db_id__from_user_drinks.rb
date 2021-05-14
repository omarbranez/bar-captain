class RemoveDrinksDbIdFromUserDrinks < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_drinks, :drinks_db_id, :integer
  end
end
