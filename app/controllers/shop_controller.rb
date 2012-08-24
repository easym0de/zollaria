class ShopController < ApplicationController
  require 'amazon/ecs'
  def search
    @search_result = {}
    @search_result[:query] = params[:query]
    @search_result[:items] = []
    
    Amazon::Ecs.configure do |options|
      options[:associate_tag] = Settings.amazon.associate_tag
      options[:AWS_access_key_id] = Settings.amazon.access_key_id
      options[:AWS_secret_key] = Settings.amazon.secret_access_key
    end
    
    res = Amazon::Ecs.item_search(params[:query], :search_index => 'All')
    first_item = res.items.first
    
    res.items.each do |item|
      current_item = {}
      item_attributes = item.get_element('ItemAttributes')
      current_item[:title] = item_attributes.get('Title')
      current_item[:category] = item_attributes.get('ProductGroup')
      @search_result[:items].push(current_item)
    end
  end


  def buy
    @title = params[:item_title]
  end
end
