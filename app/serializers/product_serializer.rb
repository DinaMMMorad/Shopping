class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_new, :picture

  def picture
    object.picture.url
  end
end
