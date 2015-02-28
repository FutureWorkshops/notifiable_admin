class NotifiableAdmin::Account < ActiveRecord::Base
  self.table_name = 'accounts'
  
  has_many :admins, :class_name => "NotifiableAdmin::Admin"
  has_many :notifications_api_users, :class_name => "Notifiable::NotificationsApiUser"
  has_many :apps, :class_name => "::Notifiable::App"
end
