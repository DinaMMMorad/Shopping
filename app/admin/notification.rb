ActiveAdmin.register Notification do
  config.batch_actions = false
  actions :all, :except => [:edit, :show]

  require 'gcm'
  require 'certified'
  permit_params :title, :message, :picture

  after_create do |notification|
    # NotificationsJob.perform_later notification
    gcm = GCM.new('AIzaSyCvNzKokdkpCNrBLcDeEEMew2e0cwkEi54')
    registration_ids = Device.get_android_reg_ids
    gcm.send(registration_ids, {data: {title: notification.title, message: notification.message, picture_url: notification.picture.url}})
  end

  index do
    selectable_column
    column :title
    column :message
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'Notification Details' do
      f.input :title
      f.input :message
      f.inputs 'Upload' do
        f.input :picture, required: true, as: :file
      end
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
