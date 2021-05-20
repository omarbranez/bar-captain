class DrinksController < ApplicationController
    
    get '/drinks' do
        redirect_if_not_logged_in
        @my_drinks= Bartender.new(current_user.id) 
        @my_drinks.create_drinks # perhaps goes in bartender class? or in products controller in "new" route.
        @drinks = current_user.drinks
        erb :'drinks/index'
    end

    get '/drinks/:slug' do
        @drink = Drink.find_by_slug(params[:slug])
        erb :'/drinks/show'        
    end


end