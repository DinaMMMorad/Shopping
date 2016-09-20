class Notification < ActiveRecord::Base

  def self.get_today_notifications
    Notification.where('DATE(created_at) = DATE(?)', Time.now).order('created_at Desc')
  end

end
