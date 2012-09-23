class Account < ActiveRecord::Base
   belongs_to :user
   def update_balance(price)
     price = price.sub('$','').to_f
     self.balance = self.balance - price
     self.save!
   end
end
