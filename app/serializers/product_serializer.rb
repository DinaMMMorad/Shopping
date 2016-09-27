class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_new, :picture, :price, :category_id

  def picture
    object.picture.url
  end
end
