class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_new, :picture, :price

  def picture
    object.picture.url
  end
end
