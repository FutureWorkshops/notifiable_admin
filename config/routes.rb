NotifiableAdmin::Engine.routes.draw do
  
  devise_for :admins, :controllers => { :sessions => "notifiable_admin/admin/sessions" }, class_name: "NotifiableAdmin::Admin"
  
  namespace :super_admin do
    resources :accounts
  end
  
  namespace :admin do
    resources :accounts, :only => [] do
      resources :apps, :except => [:index, :destroy] do
        resources :users, :only => [:index, :show]
        resources :device_tokens, :only => :index
        resources :jobs, :only => [:index, :destroy]
        resources :notifications, :only => [:new, :create, :index] do
          resources :notification_statuses, :only => :index
        end
      end
      resources :notifications_api_users, :except => :view
      resources :admins, :except => :view
      resources :api_docs, :only => :index
    end
  end

  namespace :user_api do
    namespace :v1 do
    	resources :device_tokens, :only => [:create, :update, :destroy]
    	put 'notification_statuses/opened', :to => "notification_statuses#opened"
    end
  end
  
  namespace :notifications_api do
    namespace :v1 do
      devise_for :notifications_api_user, class_name: "NotifiableAdmin::NotificationsApiUser"
      resources :notifications, :only => [:create]   
    end
  end
    
  root 'admin/sessions#new'
end
