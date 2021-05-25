class RenameTypeColumnInDrinks < ActiveRecord::Migration[6.1]
  def change
    rename_column :drinks, :type, :drink_type
  end
end
