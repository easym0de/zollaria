class Inventory < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  
  def self.check_for_duplicate_or_create(user_id, product_id)
    inventory_item = self.find_by_user_id_and_product_id(user_id, product_id)
    
    unless inventory_item.nil?
      return true
    end
    
    self.create(:user_id => user_id, :product_id => product_id)

    return false
  end
end
