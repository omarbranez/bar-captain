require 'sinatra/base'
class Bartender

    attr_reader :my_id

    def initialize(my_id)
        @my_id = my_id
    end

    def current_user
        User.find(my_id)
    end
    
    def user_products
        current_user.product_ids
    end

    def user_drinks
        current_user.drinks
    end
    
    def possible_drinks
        Drink.all.select { |drink| (drink.products.ids - user_products).empty?}
        # select is faster than map
        # so far, only exact matches. need similar. maybe drank.product_ids.size -1?
    end

    def create_drinks
        possible_drinks.each do |d|
            current_user.user_drinks.find_or_create_by(drink_id: d.id)
        end
    end

    
end
