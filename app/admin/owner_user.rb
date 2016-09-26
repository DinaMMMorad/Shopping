ActiveAdmin.register AdminUser, :as => 'Owner Details'  do
  permit_params :password, :password_confirmation
  config.clear_action_items!
  config.batch_actions = false

  #to prevent showing owner and show admin users only.
  controller do
    def scoped_collection
      AdminUser.owner
    end
  end

  index do
    selectable_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :actions do |object|
      link_to 'Change Password', edit_admin_owner_detail_path(object.id)
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs 'Change Password' do
      # f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
