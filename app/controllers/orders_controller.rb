class OrdersController < ApplicationController

  skip_before_filter :verify_authenticity_token

  api :Post, '/orders', 'Create orders'
  param :access_token, String, desc: 'authentication token', required: true
  param :orders, Array, desc: 'orders array'
  param :user_data, Hash, desc: 'user data' do
    param :full_name, String, required: true, desc: 'user full name'
    param :identity, String, required: true, desc: 'user identity'
    param :phone, String, required: true, desc: 'user phone'
    param :alternative_phone, String, required: true, desc: 'user alternative phone'
    param :country, String, required: true, desc: 'user country'
    param :address, String, required: true, desc: 'user address'
  end

  def create
    orders = params[:orders]
    orders_array = []

    orders.each do |order|
      add_order = Order.new(permit_user_data)
      add_order.user_id = order[:user_id]
      add_order.product_id = order[:product_id]
      orders_array.push(add_order)
    end

    Order.transaction do
      success = orders_array.map(&:save)
      if success.all?
        render json: {orders: orders_array}, status: :ok
      else#ToDo: confirm if it is working successfully.
        errored = orders_array.select { |b| !b.errors.blank? }
        render json: errored, status: :unprocessable_entity
      end
    end
  end

  def permit_user_data
    if params[:user_data].is_a? String
      params[:user_data]
    else
      params.require(:user_data).permit(:full_name, :identity, :phone, :alternative_phone, :country, :address)
    end

  end

end
