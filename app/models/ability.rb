class Ability
  include CanCan::Ability

  def initialize(admin_user)
    send(admin_user.role.downcase)
    can :manage, ActiveAdmin::Page, :name => 'Dashboard'
  end

  def admin
    owner
    cannot :manage, AdminUser
  end

  def owner
    can :manage, :all
  end

end
