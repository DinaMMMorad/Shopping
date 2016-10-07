class NotificationsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    gcm = GCM.new('AIzaSyCvNzKokdkpCNrBLcDeEEMew2e0cwkEi54')
    registration_ids = Device.get_android_reg_ids
    gcm.send(registration_ids, {data: {title: args[0].title, message: args[0].message, picture_url: args[0].picture.url}})
  end
end
