class Inventory < ActiveRecord::Base
  has_many :likes
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
  
  def self.check_for_duplicate(user_id, product_id)
    inventory_item = self.find_by_user_id_and_product_id(user_id, product_id)
    
    unless inventory_item.nil?
      return true
    end
    
    return false
  end
  
  def self.get_inventory_item(inventory_id, user_id)
    inventory_item = Inventory.find(inventory_id)
    product = inventory_item.product
    item = {}
    likes = []
    item[:like_button_class] = 'btn-primary'
    item[:status_text] = 'Like'
    
    #inventory_item = Inventory.find_by_user_id_and_product_id(user_id, product.id)
    inventory_item.likes.each do |like_item|
      unless like_item.active == false
        user = User.find(like_item.user_id)
        like = {}      
        like[:name] = user.name
        like[:user_id] = user.id
        likes.push(like)
  
        if user_id == user.id
          item[:like_button_class] = 'btn-danger'
          item[:status_text] = 'Liked'
        end
      end
    end
    
    item[:title] = product.title
    item[:small_image] = product.small_image
    item[:medium_image] = product.medium_image
    item[:detail_page_url] = product.detail_page_url
    item[:inventory_id] = inventory_item.id
    item[:likes] = likes
    
    return item
  end
end
