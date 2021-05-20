class AddProductRefToDrinks < ActiveRecord::Migration[6.1]
  def change
    add_reference :drinks, :product
  end
end

# next migration needs to move quantities to drink_products