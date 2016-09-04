class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category, :is_new, :image

  def image
    {
        url: "/uploads/product/avatar/#{object.id}/#{object.image}"
    }
  end
end
