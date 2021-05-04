class Product < ActiveRecord::Base 
    has_many :drink_products
    has_many :drinks, through: :drink_products
end 