class Account < ActiveRecord::Base
   belongs_to :user
   def update_balance(price)
     price = price.sub('$','').sub(',','').to_f
     self.balance = (self.balance - price).round(2)
     self.save!
   end
   
   def calculate_balance_after_purchase(price)
     price = price.sub('$','').sub(',','').to_f
     return (self.balance - price).round(2)
   end
end
