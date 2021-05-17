class RenameDrinksIdInUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_drinks, :drinks_id, :drink_id
  end
end
