class NotificationsController < ApplicationController

  api :Get, '/today_notifications', 'Retrieve today notifications'
  param :access_token, String, desc: 'authentication token', required: true

  def get_today_notifications
    notifications = Notification.get_today_notifications.paginate(page: params[:page], per_page: params[:per])
    render json: {notifications: serialized_notifications(notifications)}, status: :ok
  end

  def serialized_notifications(notifications)
    ActiveModel::Serializer::CollectionSerializer.new(notifications, each_serializer: NotificationSerializer)
  end

end
