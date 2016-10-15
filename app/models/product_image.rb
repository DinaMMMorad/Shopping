class ProductImage < ActiveRecord::Base
  belongs_to :product
  attr_accessor :product
  has_attached_file :picture, :storage => :cloudinary, :cloudinary_resource_type => :image,
                    path: "product_image/:id"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end
