class NotificationsController < ApplicationController

  api :Get, '/today_notifications', 'Retrieve today notifications'
  param :access_token, String, desc: 'authentication token', required: true

  def get_today_notifications
    render json: {notifications: Notification.get_today_notifications.paginate(page: params[:page], per_page: params[:per])}, status: :ok
  end

end
