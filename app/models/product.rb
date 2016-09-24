class Product < ActiveRecord::Base

  has_many :users
  belongs_to :category
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", 'JPG', 'image/JPG']
  validates :title, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  # before_save :save_dimensions
  #
  # def save_dimensions
  #   temp = self.picture.queued_for_write[:original]
  #   unless temp.nil?
  #     geo = Paperclip::Geometry.from_file(temp)
  #     self.width = geo.width
  #     self.height = geo.height
  #   end
    # dimensions = Paperclip::Geometry.from_file(file.queued_for_write[:picture].path)
    # self.width = dimensions.width
    # self.height = dimensions.height
    # self.width = Paperclip::Geometry.from_file(to_file(style)).width
    # self.height = Paperclip::Geometry.from_file(to_file(style)).height
  # end

  def self.new_arrivals
    Product.where(:is_new => true)
  end

  def self.category_products(category_id)
    Product.where(:category_id => category_id).all
  end
end
