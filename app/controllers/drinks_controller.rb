class DrinksController < ApplicationController
    
    get '/drinks' do
        erb :'index'
    end

    get '/show' do
        @products = current_user.products.pluck(:name) #returns an array of just the names
        # Drink.all.each do {|drink_name|}
        #     Drink.where(name)
#         drink_pluck = Drink.where(name: 'Long Island Iced Tea').pluck(:ingredient1, :ingredient2, :ingredient3, :ingredient4, :ingredient5, :ingredient6, :ingredient7, :ingredient8)
# D, [2021-05-14T20:58:22.868935 #26479] DEBUG -- :    (0.3ms)  SELECT "drinks"."ingredient1", "drinks"."ingredient2", "drinks"."ingredient3", "drinks"."ingredient4", "drinks"."ingredient5", "drinks"."ingredient6", "drinks"."ingredient7", "drinks"."ingredient8" FROM "drinks" WHERE "drinks"."name" = ?  [["name", "Long Island Iced Tea"]]
# => [["Vodka", "Tequila", "Light rum", "Gin", "Coca-Cola", "Lemon Peel", nil, nil]]
# if this is the magic query, imma commit right now
#  Drink.select('drinks.name').joins(:user_products).where(user_products: {name: user_product.names.pluck(:name)}).group("drinks.name").having('count(drinks.name) >= ?', user_product.names.pluck(:name).size)
# Drink.select('drinks.name').joins(:user_products).where(ingredient1..ingredient8: {name: user_product.names.pluck(:name)}).group("drinks.name").having('count(drinks.name) >= ?', user_product.names.pluck(:name).size)
end



end