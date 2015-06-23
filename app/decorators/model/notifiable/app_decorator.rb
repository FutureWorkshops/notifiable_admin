Notifiable::App.class_eval do
  include ApiAuthenticatable
  
  serialize :configuration
  
  has_and_belongs_to_many :admins
  has_and_belongs_to_many :notifications_api_users
  
  belongs_to :account, :class_name => "NotifiableAdmin::Account"
  validates :account, :presence => true

end
