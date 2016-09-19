class DevicesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  api :Post, '/devices', 'Add Device'
  param :access_token, String, desc: 'authentication token', required: true
  param :device, Hash, desc: 'device data' do
    param :os_name, String, required: true, desc: 'os name'
    param :reg_id, String, required: true, desc: 'registration id'
    param :user_id, String, required: true, desc: 'user id'
    param :device_name, String, required: true, desc: 'device name'
    param :os_version, Integer, required: true, desc: 'os version'
  end

  def create
    #update reg_id if device was registered previously otherwise save new device instance
    device = Device.find_device_by_name_and_user_id(params[:device][:device_name], params[:device][:user_id])

    if !device
      device = Device.new(permit_device_data)
      if device.save
        render_success(device)
      else
        render_failure(device)
      end
    else
      if device.update_attributes(permit_device_data)
        render_success(device)
      else
        render_failure(device)
      end
    end
  end

  def render_success(device)
    render json: device.as_json(:only => [:id, :os_name, :reg_id, :user_id, :os_version]), status: :created
  end


  def render_failure(device)
    render json: errors_for(device.errors), status: :unprocessable_entity
  end


  api :Delete, '/devices/destroy_with_reg_id', 'Add Device'
  param :access_token, String, desc: 'authentication token', required: true
  param :reg_id, String, desc: 'device registration id', required: true

  def destroy_with_reg_id
    device = Device.find_by_reg_id(params[:reg_id])
    if device && device.destroy
      render json: {message: I18n.t('device.messages.deleted_successfully'), status: :ok}, status: :ok
    else
      render json: {message: I18n.t('device.messages.deleted_failure'), status: :unprocessable_entity}, status: :unprocessable_entity
    end
  end

  def permit_device_data
    params.require(:device).permit(:os_name, :reg_id, :user_id, :os_version, :device_name)
  end
end
