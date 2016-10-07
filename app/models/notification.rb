class Notification < ActiveRecord::Base

  has_attached_file :picture, default_url: "/images/order.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/#['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'JPG', 'image/JPG']

  def self.get_today_notifications
    Notification.where('DATE(created_at) = DATE(?)', Time.now).order('created_at Desc')
  end

end
