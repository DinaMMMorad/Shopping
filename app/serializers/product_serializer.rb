class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_new, :product_images, :price, :category_id

  def product_images
    if object.product_images

      picture_urls = []

      object.product_images.each do |product_image|
        picture_urls.push(product_image.picture.url)
      end

      picture_urls
    end
  end
end
