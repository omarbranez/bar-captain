class Product < ActiveRecord::Base 
    belongs_to :user
    has_many :drink_products
    has_many :drinks, through: :drink_products
end 