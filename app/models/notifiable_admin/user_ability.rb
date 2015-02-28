class NotifiableAdmin::UserAbility
  include CanCan::Ability

  def initialize(user)
    return unless user
    
    can :update, user
    can :anonymise, user.device_tokens
  end
end
