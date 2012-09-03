class HomeController < ApplicationController
  def index
    @inventory = {}
    books = []
    movies = []
    gadgets = []
    unless current_user.nil?
      books = current_user.books
      movies = current_user.movies
      gadgets = current_user.gadgets 
    end
    
    Amazon::Ecs.configure do |options|
      options[:associate_tag] = Settings.amazon.associate_tag
      options[:AWS_access_key_id] = Settings.amazon.access_key_id
      options[:AWS_secret_key] = Settings.amazon.secret_access_key
    end
    
    #res = Amazon::Ecs.item_lookup('059035342X')
    #res2 = Amazon::Ecs.items_lookup('059035342X,B000QCS8TW')
    opts = {}
    opts[:IdType] = "ASIN"
    res2 = Amazon::Ecs.item_lookup('0545162076,059035342X,B000QCS8TW', opts)
    
    my_items = ''
    res2.items.each do |item|
      item_attributes = item.get_element('ItemAttributes')
      my_items = my_items + item_attributes.get('Title') + ','

    end
    
    
    @inventory[:books] = books
    @inventory[:movies] = movies
    @inventory[:gadgets] = gadgets
    @inventory[:res] = my_items
  end
end
