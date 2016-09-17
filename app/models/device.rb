class Device < ActiveRecord::Base
  belongs_to :user

  #validations
  validates :os_name, presence: true
  validates :reg_id, presence: true
  validates :user, presence: true


  def self.get_android_reg_ids
    Device.where(:os_name => 'android').pluck(:reg_id)
  end

end
