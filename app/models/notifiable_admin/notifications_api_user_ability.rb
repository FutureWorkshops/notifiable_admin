class NotifiableAdmin::NotificationsApiUserAbility
  include CanCan::Ability

  def initialize(notifications_api_user) 
    if notifications_api_user
      can :read, Notifiable::App, :id => notifications_api_user.app_ids
      can :create, Notifiable::Notification    
    end
  end
end
