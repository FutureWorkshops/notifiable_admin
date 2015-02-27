Notifiable::App.class_eval do
  serialize :configuration
  
  has_and_belongs_to_many :admins, :class_name => "NotifiableAdmin::Admin"
  has_and_belongs_to_many :notifications_api_users, :class_name => "NotifiableAdmin::NotificationsApiUser"
  
  belongs_to :account, :class_name => "NotifiableAdmin::Account"
  validates :account, :presence => true
end
