class DrinksController < ApplicationController

    get '/drinks' do
        redirect_if_not_logged_in
        # also want to see if any changes were made before we query again
        @user_drinks = current_user.drinks
        @random_drink = Drink.offset(rand(556)).first
        erb :'drinks/index'
    end
    
    get '/drinks/generate' do
        redirect_if_not_logged_in
        create_drinks
        redirect '/drinks'
    end

    get '/drinks/:slug' do
        @drink = Drink.find_by_slug(params[:slug])
        @drink_products = DrinkProduct.select("product_id, quantity").where(drink_id: @drink.id)
        if !!logged_in?
        # guests dont have any drinks
            makeable_drink_validation
        end
        erb :'/drinks/show'        
    end

    get '/drinks/new' do
        redirect_if_not_logged_in
    end

    helpers do

        def user_product_ids
            current_user.product_ids
        end

        def user_drinks
            current_user.drinks
        end
    
        def possible_drinks
            Drink.all.select { |drink| (drink.products.ids - user_product_ids).empty?}
        # using ids only due to speed
        # this returns an array of drink ids
        # removed need for similar, thanks to backlinks        
        end

        def makeable_drink_check
            @drink.products - current_user.products
        end
    
        def makeable_drink_validation # ouch
            if makeable_drink_check.empty?
                @makeable = "True"
                if !current_user.user_drinks.where(drink_id: @drink.id).exists?
                    current_user.user_drinks.find_or_create_by(drink_id: @drink.id)
        # if the difference of collections is zero BUT the drink doesn't exist in the user's collection, aka they added something in products and didn't hit the generate button
        # add to the collection
                end
            else
                @makeable = "False"
                @missing_products = makeable_drink_check
                if current_user.user_drinks.where(drink_id: @drink.id).exists?
                    current_user.user_drinks.find_by(drink_id: @drink.id).delete
        # if the difference is not zero BUT the drink exists in the user's collection, aka they deleted stuff in products
        # remove it from the collection
                end
            end
        end

        def create_drinks
            possible_drinks.each do |d|
                current_user.user_drinks.find_or_create_by(drink_id: d.id)
            end
        end

    end



end