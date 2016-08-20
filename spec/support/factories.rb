FactoryGirl.define do

  sequence(:password) {|n| "password#{n}" }

  factory :empty_account, :class => NotifiableAdmin::Account do
    sequence(:name) {|n| "Account #{n}" }
    
    factory :account do
      after(:create) do |account, evaluator|
        FactoryGirl.create(:app, :account => account) if account.apps.empty?
      end
    end
  end
  
  factory :app, :class => Notifiable::App do
    sequence(:name) {|n| "My App #{n}" }
    account
    
    after(:create) do |app, evaluator|
      app.apns_certificate = File.read(File.join(File.dirname(__FILE__), "..", "fixtures", "apns-development.pem"))
      app.apns_sandbox = "0"
      app.save
    end
  end
  
  factory :user, :class => NotifiableAdmin::User do
    sequence(:alias) {|n| (n + 10000).to_s }
    app

    factory :user_with_apns_token do
      after(:create) do |user, evaluator|
        FactoryGirl.create(:apns_token, :user_id => user.id)
      end
    end
    
    factory :user_with_gcm_token do
      after(:create) do |user, evaluator|
        FactoryGirl.create(:gcm_token, :user_id => user.id)
      end
    end  
  end

  factory :admin, :class => NotifiableAdmin::Admin do
    account
    sequence(:email) {|n| "admin-#{n}@example.com" }
    password 
    
    factory :super_admin, :class => NotifiableAdmin::Admin do
      role "super_admin"
      account nil
    end
    
    factory :account_owner, :class => NotifiableAdmin::Admin do
      role "account_owner"
    end
    
    factory :content_admin, :class => NotifiableAdmin::Admin do
      role "content_admin"
      apps {[FactoryGirl.create(:app)]}
    end
  end
  
  
  factory :notifications_api_user, :class => NotifiableAdmin::NotificationsApiUser do
    sequence(:service_name) {|n| "service-#{n}"}
    apps {[FactoryGirl.create(:app)]}
  end
  
  factory :user_api_user, :class => NotifiableAdmin::UserApiUser do
    sequence(:service_name) {|n| "service-#{n}"}
    app
  end
  
  factory :notification, :class => Notifiable::Notification do
    app
  end
  
  factory :localized_notification, :class => Notifiable::LocalizedNotification do
    notification
    message "Hello!"
  end
  
  factory :job, :class => "Delayed::Job" do
  end

  factory :device_token, :class => Notifiable::DeviceToken do
    app    
    locale :en
    
    # need to do this to pass lint
    provider :apns
    sequence(:token) {|n| "XXX#{n}" }
    
    factory :apns_token do
      provider :apns
      sequence(:token) {|n| "ABCD#{n}" }
    end
    
    factory :gcm_token do
      provider :apns
      sequence(:token) {|n| "ZXY#{n}" }
    end
  end
  
  factory :notification_status, :class => Notifiable::NotificationStatus do
    localized_notification
    device_token
    status 0
  end

  
end