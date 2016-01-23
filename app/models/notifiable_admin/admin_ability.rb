class NotifiableAdmin::AdminAbility
  include CanCan::Ability

  def initialize(admin) 
    return unless admin
    
    if admin.account_owner?
      can :read, NotifiableAdmin::Account, :id => admin.account_id    
      can :create, Notifiable::App      
      can :create, NotifiableAdmin::Admin    
      can :create, NotifiableAdmin::NotificationsApiUser
      can :create, NotifiableAdmin::UserApiUser
      can :create, Notifiable::Notification

      can [:read, :update, :destroy], NotifiableAdmin::Admin, :account => {:id => admin.account_id}
      can [:read, :update, :destroy], NotifiableAdmin::NotificationsApiUser, :account => {:id => admin.account_id}
      can [:read, :update, :destroy], NotifiableAdmin::UserApiUser, :app => {:account => {:id => admin.account_id}}
      can [:read, :update, :destroy], Notifiable::App, :account => {:id => admin.account_id}
      can [:read, :destroy], Delayed::Job
      
      can :read, Notifiable::Notification, :app => {:account => {:id => admin.account_id}}
      can :read, Notifiable::NotificationStatus, :notification => {:app => {:account => {:id => admin.account_id}}}
      can :read, Notifiable::DeviceToken, :app => {:account => {:id => admin.account_id}}
      can :read, NotifiableAdmin::User, :device_tokens => {:app => {:account => {:id => admin.account_id}}}
    else
      can :read, NotifiableAdmin::Account, :id => admin.account_id    
      can :create, Notifiable::Notification

      can :read, Notifiable::App, :admins => {:id => admin.id}
      can :read, Notifiable::Notification, :app => {:admins => {:id => admin.id}}
      can :read, Notifiable::NotificationStatus, :notification => {:app => {:admins => {:id => admin.id}}}
      can :read, Notifiable::DeviceToken, :app => {:admins => {:id => admin.id}}
      can :read, NotifiableAdmin::User, :device_tokens => {:app => {:admins => {:id => admin.id}}}
      can [:read, :destroy], Delayed::Job
      
    end
  end
end
