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
    device = Device.find_by_device_name(params[:device][:name])
    device.reg_id = params[:device][:reg_id]

    if !device
      device = Device.new(permit_device_data)
    end

    #save device
    if device.save
      render json: device.as_json(:only => [:id, :os_name, :reg_id, :user_id, :os_version]), status: :created
    else
      render json: errors_for(device.errors), status: :unprocessable_entity
    end
  end

  def permit_device_data
    params.require(:device).permit(:os_name, :reg_id, :user_id, :os_version, :device_name)
  end
end
