class Product < ActiveRecord::Base
  has_many :inventories
  has_many :users, :through => :inventories
  
  def self.update_or_create(params)
    product = self.find_or_create_by_asin(params[:asin])
    product.title = params[:title]
    product.category = params[:category]
    product.detail_page_url = params[:detail_page_url]
    product.small_image = params[:small_image]
    product.price = params[:price]
    product.save
    return product
  end
end
