class NotifiableAdmin::UserApiUser < ActiveRecord::Base
  self.table_name = 'user_api_users'
  
  devise :trackable, :lockable
  
  include ApiAuthenticatable
  
  belongs_to :app, :class_name => "::Notifiable::App"
  validates :app, :presence => true
end
