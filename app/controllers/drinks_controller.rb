class DrinksController < ApplicationController
    # include Bartender

    get '/drinks' do
        redirect_if_not_logged_in
        # also want to see if any changes were made before we query again
        @user_drinks = current_user.drinks
        @random_drink = Drink.offset(rand(557)).first
        erb :'drinks/index'
    end
    
    get '/drinks/generate' do
        redirect_if_not_logged_in
        Bartender.new(current_user.id).create_drinks
        redirect '/drinks'
    end

    get '/drinks/:slug' do
        redirect_if_not_logged_in
        @drink = Drink.find_by_slug(params[:slug])
        @drink_products = DrinkProduct.select("product_id, quantity").where(drink_id: @drink.id)
        if logged_in?
            if current_user.user_drinks.where(drink_id: @drink.id).exists?
                @makeable = "True"
            else
                @missing_products = Bartender.new(current_user.id, @drink.id).missing_products
            end
        end
        erb :'/drinks/show'        
    end

    get '/drinks/new' do
        redirect_if_not_logged_in
    end



end