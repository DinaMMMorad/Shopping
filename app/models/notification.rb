class Notification < ActiveRecord::Base

  def self.get_today_notifications
    Notification.where(:created_at => Date.today)
  end

end
