class SearchController < ApplicationController
  require amazon/ecs
  def search_result
    @search_result = {}
    @search_result[:query] = params[:query]
    
    Amazon::Ecs.configure do |options|
      options[:associate_tag] = Settings.amazon.associate_tag
      options[:AWS_access_key_id] = Settings.amazon.access_key_id
      options[:AWS_secret_key] = Settings.amazon.secret_access_key
    end
    
    res = Amazon::Ecs.item_search(@search_result[:query], :search_index => 'All')
    first_item = res.items.first
    
    puts first_item.inspect
    
    item_attributes = first_item.get_element('ItemAttributes')
    @search_result[:count] = res.items.count
    @search_result[:title] = item_attributes.get('Title')
    @search_result[:category] = item_attributes.get('ProductGroup')
  end
end
