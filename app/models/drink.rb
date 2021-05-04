class Drink < ActiveRecord::Base 
    has_many :menu_drinks
    has_many :menus, through: :menu_drinks
    has_many :drink_products
    has_many :products, through: :drink_products
end