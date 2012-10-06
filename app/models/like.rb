class Like < ActiveRecord::Base
  belongs_to :inventory
  
  def self.update_or_create(user_id, inventory_id)
    like = self.find_or_create_by_user_id_and_inventory_id(user_id, inventory_id)
    like.active = true
    like.save
    return like
  end
  
  def self.unlike(user_id, inventory_id)
    like = self.find_by_user_id_and_inventory_id(user_id, inventory_id)
    like.active = false
    like.save
    return like
  end
end
