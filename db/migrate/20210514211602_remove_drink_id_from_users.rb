class RemoveDrinkIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :drink_id, :integer
  end
end
