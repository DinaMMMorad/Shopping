class Notification < ActiveRecord::Base

  has_attached_file :picture, :storage => :cloudinary, :cloudinary_resource_type => :image,
                    path: "notification/:id", :default_url => ''
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  def self.get_today_notifications
    Notification.where('DATE(created_at) = DATE(?)', Time.now).order('created_at Desc')
  end

end
