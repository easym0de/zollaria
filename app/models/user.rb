class User < ActiveRecord::Base
  require 'amazon/ecs'
  has_one :account
  has_many :inventories
  has_many :products, :through => :inventories
  def self.from_omniauth(auth)
    user = where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
    
     if user.account.nil?
      account = user.build_account
      account.balance = 500.00
      account.save!
    end
    
    return user
  end
  
  def get_inventory(current_user)
    items = {}
    items_col1 = []
    items_col2 = []
    items_col3 = []
    items_col4 = []
    products = self.products
    unless products.blank?
      products.each_with_index do |product, index|
        item = {}
        likes = []
        unless product.title.blank?
          
          item[:like_button_class] = 'btn-primary'
          item[:status_text] = 'Like'
          
          inventory_item = Inventory.find_by_user_id_and_product_id(self.id, product.id)
          inventory_item.likes.each do |like_item|
            unless like_item.active == false
              user = User.find(like_item.user_id)
              like = {}
              like[:name] = user.name
              like[:user_id] = user.id
              likes.push(like)
              if current_user.id == user.id
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

          if index % 4 == 0
            items_col1.push(item)
          elsif index % 4 == 1
            items_col2.push(item)
          elsif index % 4 == 2
            items_col3.push(item)
          elsif index % 4 == 3
            items_col4.push(item)
          end

        end
      end
    end
    items[:items_col1] = items_col1
    items[:items_col2] = items_col2
    items[:items_col3] = items_col3
    items[:items_col4] = items_col4
    return items
  end
  
  
  
  def get_balance
    account = self.account
    unless account.blank?
      balance = account.balance
    end
    return balance
  end
  
  def calculate_balance_after_purchase(price)
    account = self.account
    return account.calculate_balance_after_purchase(price)
  end
  
  def buy(price)
    account = self.account
    account.update_balance(price)
  end
  
  def self.search(params)
    items = {}
    items_col1 = []
    items_col2 = []
    items_col3 = []
    items_col4 = []
    @search_result = {}
    @search_result[:query] = params[:query]
    @search_result[:items] = []

    opts = {}
    opts[:response_group] = "Large"
    opts[:search_index] = "All"
    
    res = Amazon::Ecs.item_search(params[:query], opts)
    
    res.items.each do |item|
      current_item = {}
      item_attributes = item.get_element('ItemAttributes')
      current_item[:title] = item_attributes.get('Title')
      current_item[:category] = item_attributes.get('ProductGroup')
      current_item[:asin] = item.get('ASIN')
      current_item[:detail_page_url] = item.get('DetailPageURL')
      #current_item[:small_image] = item.get_hash('SmallImage')["URL"]
      unless item.get_hash('ImageSets/ImageSet/SmallImage').blank?
        current_item[:small_image] = item.get_hash('ImageSets/ImageSet/SmallImage')["URL"]
      end
      
      unless item.get_hash('ImageSets/ImageSet/MediumImage').blank?
        current_item[:medium_image] = item.get_hash('ImageSets/ImageSet/MediumImage')["URL"]
      end

      offer = item.get('Offers/Offer/OfferListing/Price/FormattedPrice')
      
      if offer.blank?
        current_item[:price] = item.get('OfferSummary/LowestNewPrice/FormattedPrice')
      else
        current_item[:price] = offer
      end

      if !item_attributes.get('Binding').blank? && item_attributes.get('Binding').include?('Amazon Instant Video') 
      else
        column = self.calculate_column(items_col1, items_col2, items_col3, items_col4)
        if column == 1
          items_col1.push(current_item)
        elsif column == 2
          items_col2.push(current_item)
        elsif column == 3
          items_col3.push(current_item)
        elsif column == 4
          items_col4.push(current_item)
        end
      end
    end
    
    items[:items_col1] = items_col1
    items[:items_col2] = items_col2
    items[:items_col3] = items_col3
    items[:items_col4] = items_col4
    @search_result[:items] = items
    return @search_result
    
  end
  
  def self.calculate_column(col1, col2, col3, col4)
    if col1.size == col4.size
      return 1
    end
    if col2.size == col4.size
      return 2
    end
    if col3.size == col4.size
      return 3
    end
    return 4
  end

end

