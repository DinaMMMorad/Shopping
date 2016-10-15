class Product < ActiveRecord::Base

  has_many :users
  has_many :orders, :dependent => :destroy
  belongs_to :category
  has_many :product_images, :dependent => :destroy , :autosave => true
  # accepts_nested_attributes_for :product_images, allow_destroy: true

  accepts_nested_attributes_for :product_images,
                                # :reject_if => lambda { |attributes| attributes[:picture].blank? },
                                :allow_destroy => true

  validates :title, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  def self.new_arrivals
    Product.where(:is_new => true)
  end

  def self.category_products(category_id)
    Product.where(:category_id => category_id).all
  end

  def self.search_product(product_category_id, search_text)
    Product.where('category_id = ? AND (lower(title) LIKE ? OR lower(description) LIKE ?)', product_category_id, "%#{search_text.downcase}%", "%#{search_text.downcase}%").all
  end

  def self.search_new_arrivals(search_text)
    Product.where('is_new = ? AND (lower(title) LIKE ? OR lower(description) LIKE ?)', true, "%#{search_text.downcase}%", "%#{search_text.downcase}%").all
  end
end
