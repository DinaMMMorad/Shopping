class Product < ActiveRecord::Base

  has_many :users

  def self.new_arrivals
    Product.where(:is_new => true).all
  end

  def self.category_products(category)
    Product.where(:categort => category).all
  end
end
