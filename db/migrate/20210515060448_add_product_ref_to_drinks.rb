class AddProductRefToDrinks < ActiveRecord::Migration[6.1]
  def change
    add_reference :drinks, :product
  end
end

# class ChangeIngredientsToArray < ActiveRecord::Migration[6.1]
#   def change
#     add_column :drinks, :product_id_array, :integer, array: true, default: [] #this is so we can compare in one query against user_products
    # we are also converting to an array of ids since that would be faster to compare
    # drinks = Drink.all
    # drinks.each do |drink|
    #   drink.product_id_array << Product.find_by(name: drink.ingredient1).id unless !drink.ingredient1.present?
    #   drink.product_id_array << Product.find_by(name: drink.ingredient2).id unless !drink.ingredient2.present? 
    #   drink.product_id_array << Product.find_by(name: drink.ingredient3).id unless !drink.ingredient3.present?
    #   drink.product_id_array << Product.find_by(name: drink.ingredient4).id unless !drink.ingredient4.present?
    #   drink.product_id_array << Product.find_by(name: drink.ingredient5).id unless !drink.ingredient5.present?
    #   drink.product_id_array << Product.find_by(name: drink.ingredient6).id unless !drink.ingredient6.present?
    #   drink.product_id_array << Product.find_by(name: drink.ingredient7).id unless !drink.ingredient7.present?
    #   drink.product_id_array << Product.find_by(name: drink.ingredient8).id unless !drink.ingredient8.present?
    #   drink.save
    # end
    # new_pluck_1 << drink_pluck_1.first.compact.map {|dp| Product.find_by(name: dp).id} #nested
    # new_pluck_1 =  drink_pluck_1.first.compact.map {|dp| Product.find_by(name: dp).id}
    # drink_pluck_1 = Drink.where(name: 'Long Island Iced Tea').pluck(:ingredient1, :ingredient2, :ingredient3, :ingredient4, :ingredient5, :ingredient6, :ingredient7, :ingredient8)  
    # Product.find_by(name: drink_pluck_1.first.first).id => 213 Vodka
    # Product.find_by(name: drink_pluck_1.first.second).id => 216 Tequila

