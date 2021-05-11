class Drink < ActiveRecord::Base 
    has_many :drink_products
    has_many :products, through: :drink_products
end