class NotifiableAdmin::SuperAdminAbility
  include CanCan::Ability

  def initialize(admin)     
    can :manage, NotifiableAdmin::Account if admin && admin.super_admin?
  end
end
