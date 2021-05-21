class UserDrink < ActiveRecord::Base
    belongs_to :user
    belongs_to :drink

    # if user_changes? true
    # destroy user_drinks for that user
    
end