class Drink < ActiveRecord::Base 
    has_many :user_drinks
    has_many :users, through: :user_drinks
    has_many :drink_products
    has_many :products, through: :drink_products

    def slug
        name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Drink.all.find {|drink| drink.slug == slug }
    end

end