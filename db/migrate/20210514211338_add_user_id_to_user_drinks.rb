class AddUserIdToUserDrinks < ActiveRecord::Migration[6.1]
  def change
    add_column :user_drinks, :user_id, :integer
  end
end
