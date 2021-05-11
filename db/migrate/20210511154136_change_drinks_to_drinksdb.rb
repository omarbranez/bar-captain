class ChangeDrinksToDrinksdb < ActiveRecord::Migration[6.1]
  def change
    rename_table :drinks, :drinks_db
  end
end
