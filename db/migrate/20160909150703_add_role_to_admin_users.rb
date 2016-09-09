class AddRoleToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :role, :string

    AdminUser.create! do |u|
      u.email     = 'owner@mallonline.com'
      u.password    = 'mallonline'
      u.role = 'owner'
    end
  end
end
