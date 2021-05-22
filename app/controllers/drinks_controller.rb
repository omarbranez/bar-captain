class DrinksController < ApplicationController
    
    get '/drinks' do
        # fit userslug in first, for readability
        redirect_if_not_logged_in
        # if user_changes? true
        # @my_drinks = Bartender.new(current_user.id) 
        # @my_drinks.create_drinks # perhaps goes in bartender class? or in products controller in "new" route.
        # also want to see if any changes were made before we query again
        @user_drinks = current_user.drinks
        @random_drink = Drink.order('RAND()').first
        # just to add to the page, since it's mostly unused space pre-css'ing
        erb :'drinks/index'
        # binding.pry
    end

    get '/drinks/:slug' do
        redirect_if_not_logged_in
        drink = Drink.find_by_slug(params[:slug]) # slow search ~3.5ms
        @drink_products = DrinkProduct.select("product_id, drink_id").where(drink_id: drink.id) # quick! 0.2-0.3 seconds per query
        # order of select and where. apparently where goes first?
        # would probably be faster without the slug.
        # binding.pry
        # and drink_product, once we add product quantity
        erb :'/drinks/show'        
    end


end