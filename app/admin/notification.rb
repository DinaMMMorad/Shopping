ActiveAdmin.register Notification do
  config.batch_actions = false
  actions :all, :except => [:edit, :show]

  require 'gcm'
  require 'certified'
  permit_params :title, :message


  before_create do |notification|
    gcm = GCM.new('AIzaSyCvNzKokdkpCNrBLcDeEEMew2e0cwkEi54')
    registration_ids = Device.get_android_reg_ids
    gcm.send(registration_ids, {data: {title: notification.title, message: notification.message}})
    # params[:item].merge!({ user_id: current_curator.id })
  end


  index do
    selectable_column
    column :title
    column :message
    column :created_at
    actions
  end

  # filter :email
  # filter :current_sign_in_at
  # filter :sign_in_count
  # filter :created_at
  #
  form do |f|
    f.inputs 'Notification Details' do
      f.input :title
      f.input :message
    end
    f.actions
  end

  show do |notification|
    attributes_table do
      row :title
      row :message
    end
  end

end
