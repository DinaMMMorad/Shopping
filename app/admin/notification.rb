ActiveAdmin.register Notification do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  require 'gcm'
  require 'certified'
  permit_params :title, :message


  before_create do |notification|
    gcm = GCM.new('AIzaSyCvNzKokdkpCNrBLcDeEEMew2e0cwkEi54') # Server key from Step 1
    registration_ids = ['APA91bHWdSUlf-NR77c0P-nFoPow2R2vR-p86t1rM5u9yDGXuOXw4GBFFkwuaJEitH_WtoPJrGEBoDuLE_qdWibsOg1lYpXlZSQHo5Zqrc5lqNog3QICTn8']
    gcm.send(registration_ids, {data: {title: 'title', message: 'message'}})
    # params[:item].merge!({ user_id: current_curator.id })
  end


  index do
    selectable_column
    column :title
    column :message
    column :created_at
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
