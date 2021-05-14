class RemoveMakeableFromDrinks < ActiveRecord::Migration[6.1]
  def change
    remove_column :drinks, :makeable, :boolean
  end
end
