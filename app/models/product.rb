class Product < ActiveRecord::Base 
    validates_uniqueness_of(:name)
    has_many :user_products
    has_many :users, through: :products
    has_many :drink_products
    has_many :drinks, through: :drink_products

    def slug
        name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Product.all.find {|product| product.slug == slug }
    end

    # will refactor into single module
end 