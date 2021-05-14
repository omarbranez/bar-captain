class Product < ActiveRecord::Base 
    has_many :user_products
    has_many :users, through: :products
    has_many :drink_products
    has_many :drinks, through: :drink_products

    # def self.search(search)
    #     where('name like :pat or content like :pat', :pat => "%#{search}%")
    # end
end 