class UserProduct < ActiveRecord::Base
    belongs_to :user
    belongs_to :product

    # def user_products_changed?
    # if user_products updated?
    # update user_drinks (destroy old record, re-run possible_drinks and create_drinks)

end