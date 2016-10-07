class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :title, :message, :picture

  def picture
    if object.picture.exists?
      object.picture.url
    end
  end
end
