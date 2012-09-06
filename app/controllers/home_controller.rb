class HomeController < ApplicationController
  def index
    @inventory = {}
    items = []
    
    unless current_inventory.nil?
      inventory = current_inventory.asin
    end
    
    Amazon::Ecs.configure do |options|
      options[:associate_tag] = Settings.amazon.associate_tag
      options[:AWS_access_key_id] = Settings.amazon.access_key_id
      options[:AWS_secret_key] = Settings.amazon.secret_access_key
    end
    
    #res = Amazon::Ecs.item_lookup('059035342X')
    #res2 = Amazon::Ecs.items_lookup('059035342X,B000QCS8TW')
    #opts = {}
    #opts[:IdType] = "ASIN"
    #res2 = Amazon::Ecs.item_lookup('0545162076,059035342X,B000QCS8TW', opts)
    
    #my_items = ''
    #res2.items.each do |item|
    #  item_attributes = item.get_element('ItemAttributes')
    #  my_items = my_items + item_attributes.get('Title') + ','

    #end
    titles = ''
    unless inventory.blank?
      inventory.split(',').each do |id|
        inventory_item = Product.find_by_asin(id)
        unless inventory_item.blank?
          item = {}
          unless inventory_item.title.blank?
            item[:title] = inventory_item.title
            items.push(item)
          end
        end
      end
    end
    
    @inventory[:inventory] = inventory
    @inventory[:items] = items
  end
end
