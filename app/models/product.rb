class Product < ActiveRecord::Base

  has_many :users
  belongs_to :category
  has_attached_file :picture, default_url: "/images/missing.jpg"
  validates_attachment_content_type :picture, :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'JPG', 'image/JPG']
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
    Product.where('category_id = ? AND (title LIKE ? OR description LIKE ?)', product_category_id, "%#{search_text}%", "%#{search_text}%").all
  end

  def self.search_new_arrivals(product_title)
    Product.where('is_new = ? AND title = ?', true, product_title).all
  end
end
