ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  #to prevent showing owner and show admin users only.
  controller do
    def scoped_collection
      AdminUser.admin
    end
  end

  index do
    selectable_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      # f.input :role, :as => :select, :collection => %w(owner admin), :include_blank => false
    end
    f.actions
  end

end
