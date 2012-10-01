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
  
  def get_inventory
    items = {}
    items_col1 = []
    items_col2 = []
    items_col3 = []
    items_col4 = []
    products = self.products
    unless products.blank?
      products.each_with_index do |product, index|
        item = {}
        unless product.title.blank?
          item[:title] = product.title
          item[:small_image] = product.small_image
          item[:medium_image] = product.medium_image
          item[:detail_page_url] = product.detail_page_url
          item[:inventory_id] = Inventory.find_by_user_id_and_product_id(self.id, product.id).id

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
  
  def buy(price)
    account = self.account
    account.update_balance(price)
  end
  
  def self.search(params)
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
        @search_result[:items].push(current_item)
      end
    end
    
    return @search_result
    
  end
end
