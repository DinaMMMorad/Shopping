class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  #to prevent showing owner and show admin users only.
  scope :admin, -> { where(role: 'admin') }

  adminRoles = [:owner, :admin]
end
