class Product < ActiveRecord::Base

  has_many :users
  belongs_to :category
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", 'JPG', 'image/JPG']
  validates :title, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  def self.new_arrivals
    Product.where(:is_new => true)
  end

  def self.category_products(category_id)
    Product.where(:categories => category_id).all
  end
end
