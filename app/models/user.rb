class User < ActiveRecord::Base
    has_secure_password 
    validates_uniqueness_of(:username)
    has_many :user_products
    has_many :products, through: :user_products
    has_many :user_drinks
    has_many :drinks, through: :user_drinks

    def slug
        username.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        User.all.find {|user| user.slug == slug }
    end    

end