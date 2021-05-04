class Menu < ActiveRecord::Base
    belongs_to :user
    has_many :drinks
    has_many :drinks, through: :drink_products 
end