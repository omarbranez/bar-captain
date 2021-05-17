class DrinkProduct < ActiveRecord::Base
    belongs_to :drink
    belongs_to :product 
end